resource "helm_release" "cert-manager" {
  namespace        = var.namespace
  create_namespace = true
  name             = "cert-manager"
  repository       = "https://charts.jetstack.io"
  chart            = "cert-manager"
  version          = var.cert_manager_chart_version
  cleanup_on_fail  = true

  # Helm chart deployment can sometimes take longer than the default 5 minutes
  timeout = var.timeout_seconds

  set {
    name  = "installCRDs"
    value = "true"
  }
}

resource "helm_release" "trust-manager" {
  depends_on = [helm_release.cert-manager]

  namespace        = var.namespace
  create_namespace = true
  name             = "trust-manager"
  repository       = "https://charts.jetstack.io"
  chart            = "trust-manager"
  version          = var.trust_manager_chart_version
  cleanup_on_fail  = true

  # Helm chart deployment can sometimes take longer than the default 5 minutes
  timeout = var.timeout_seconds
}

resource "kubectl_manifest" "cert-manager-cluster-issuer" {
  depends_on = [helm_release.cert-manager, helm_release.trust-manager]

  force_new = true
  server_side_apply = true

  yaml_body = templatefile("${path.module}/cluster_issuer.tfpl.yaml", {
    namespace = var.namespace,
  })
}
