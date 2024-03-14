resource "helm_release" "traefik" {
  namespace        = var.namespace
  create_namespace = true
  name             = "traefik"
  repository       = "https://traefik.github.io/charts"
  chart            = "traefik"
  version          = var.traefik_chart_version
  cleanup_on_fail  = true

  # Helm chart deployment can sometimes take longer than the default 5 minutes
  timeout = var.timeout_seconds

  # If values file specified by the var.values_file input variable exists then apply the values from this file
  # else apply the default values from the chart
  values = [fileexists("${path.root}/${var.values_file}") == true ? templatefile("${path.root}/${var.values_file}", merge({
    traefik_dashboard_username = base64encode("admin")
    traefik_dashboard_password = base64encode(random_password.traefik_dashboard_password.result)
  }, var.traefik_template_values)) : ""]

  set {
    name  = "deployment.replicas"
    value = var.replica_count
  }
}

resource "random_password" "traefik_dashboard_password" {
  length           = 128
  special          = true
  override_special = "_%@"
  upper            = true
  lower            = true
}
