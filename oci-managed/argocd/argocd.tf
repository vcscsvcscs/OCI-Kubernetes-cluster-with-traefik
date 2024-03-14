resource "helm_release" "argocd" {
  namespace        = var.namespace
  create_namespace = true
  name             = "argo"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = var.argocd_chart_version
  cleanup_on_fail  = true

  # Helm chart deployment can sometimes take longer than the default 5 minutes
  timeout = var.timeout_seconds

  set {
    name  = "configs.params.server\\.insecure"
    value = "true"
  }
}

resource "kubectl_manifest" "dashboard-ingress" {
  depends_on = [helm_release.argocd]
  
  server_side_apply = true

  yaml_body  = templatefile("${path.module}/argocd_ingress_route.tfpl.yaml", {
      namespace = var.namespace,
      my_domain = var.my_domain
    })
}