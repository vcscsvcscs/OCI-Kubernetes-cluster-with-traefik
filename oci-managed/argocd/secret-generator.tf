resource "helm_release" "secret-generator" {
  namespace        = var.namespace
  create_namespace = true
  name             = "secret-generator"
  repository       = "oci://ghcr.io/sap/secret-generator-helm"
  chart            = "secret-generator"
  cleanup_on_fail  = true

  timeout = var.timeout_seconds
}