output "argocd_url" {
  value = "argocd.${var.my_domain}"
}

output "argo_helm_values_overrides" {
  value = helm_release.argocd.metadata[0].values
}
