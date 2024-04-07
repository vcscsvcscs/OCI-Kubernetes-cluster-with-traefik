resource "helm_release" "longhorn" {
  count = var.install_longhorn ? 1 : 0
  namespace        = "longhorn-system"
  create_namespace = true
  name             = "longhorn"
  repository       = "https://charts.longhorn.io"
  chart            = "longhorn"
  version          = var.longhorn_chart_version
  cleanup_on_fail  = true

  # Helm chart deployment can sometimes take longer than the default 5 minutes
  timeout = var.timeout_seconds
}
