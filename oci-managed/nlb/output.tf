output "traefik_dashboard_password" {
  value     = random_password.traefik_dashboard_password.result
  sensitive = true
}

output "traefik_dashboard_username" {
  value     = "admin"
  sensitive = true
}

output "traefik_nlb_public_ip" {
  value = local.traefik_nlb_public_ip
}

resource "local_file" "traefik_values" {
  content = templatefile("${path.root}/${var.values_file}", merge({
    traefik_dashboard_username = base64encode("admin")
    traefik_dashboard_password = base64encode(random_password.traefik_dashboard_password.result)
  }, var.traefik_template_values))
  filename = "${path.module}/traefik_values.yaml"
}