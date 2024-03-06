output "traefik_dashboard_password" {
    value = random_password.traefik_dashboard_password.result
    sensitive = true
}

output "traefik_dashboard_username" {
    value = "admin"
    sensitive = true
}
