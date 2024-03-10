data "oci_network_load_balancer_network_load_balancers" "traefik" {
  compartment_id = var.compartment_ocid
  state          = "Active"
  depends_on     = [helm_release.traefik]
}

locals {
  traefik_nlb_public_ip = data.oci_network_load_balancer_network_load_balancers.traefik.network_load_balancer_collection[0].items[0].ip_addresses[0].ip_address
}

data "cloudflare_zone" "dns_zone" {
  name = var.traefik_template_values.my_domain
}

resource "cloudflare_record" "main_domain" {
  type       = "A"
  name       = var.traefik_template_values.my_domain
  zone_id    = data.cloudflare_zone.dns_zone.id
  proxied    = true
  value      = local.traefik_nlb_public_ip
  depends_on = [helm_release.traefik, data.oci_network_load_balancer_network_load_balancers.traefik, data.cloudflare_zone.dns_zone]
}

resource "cloudflare_record" "traefik" {
  type       = "A"
  name       = "traefik"
  proxied    = true
  zone_id    = data.cloudflare_zone.dns_zone.id
  value      = local.traefik_nlb_public_ip
  depends_on = [helm_release.traefik, data.oci_network_load_balancer_network_load_balancers.traefik, data.cloudflare_zone.dns_zone]
}

resource "cloudflare_record" "wildcard" {
  type       = "A"
  name       = "*"
  proxied    = true
  value      = local.traefik_nlb_public_ip
  zone_id    = data.cloudflare_zone.dns_zone.id
  depends_on = [helm_release.traefik, data.oci_network_load_balancer_network_load_balancers.traefik, data.cloudflare_zone.dns_zone]
}
