output "traefik_dashboard_username" {
    value = module.nlb.traefik_dashboard_username
    sensitive = true
}

output "traefik_dashboard_password" {
    value = module.nlb.traefik_dashboard_password
    sensitive = true
}