output "argocd_url" {
  value = "argocd.${var.my_domain}"
}

output "argo_helm_values_overrides" {
  value = helm_release.argocd.metadata[0].values
}

output "argocd_ingress_route" {
  value = kubectl_manifest.dashboard-ingress.yaml_body_parsed
}