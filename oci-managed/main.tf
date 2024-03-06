
module "vcn" {
  source  = "oracle-terraform-modules/vcn/oci"
  version = "3.6.0"

  compartment_id = var.compartment_ocid
  region         = var.region

  internet_gateway_route_rules = null
  local_peering_gateways       = null
  nat_gateway_route_rules      = null

  vcn_name      = "${var.cluster_name}-${var.environment}-vcn"
  vcn_dns_label = "${var.cluster_name}${var.environment}vcn"
  vcn_cidrs     = ["10.0.0.0/16"]

  create_internet_gateway = true
  create_nat_gateway      = true
  create_service_gateway  = true
}

module "snet" {
  source = "./snet"

  compartment_ocid = var.compartment_ocid
  cluster_name     = var.cluster_name
  environment      = var.environment

  vcn_id           = module.vcn.vcn_id
  vcn_nat_route_id = module.vcn.nat_route_id
  vcn_ig_route_id  = module.vcn.ig_route_id
}

module "oke" {
  source = "./oke"

  compartment_ocid = var.compartment_ocid
  cluster_name     = var.cluster_name
  environment      = var.environment

  vcn_id                    = module.vcn.vcn_id
  vcn_public_subnet_id      = module.snet.public_subnet_id
  vcn_private_subnet_id     = module.snet.private_subnet_id
  node_availability_domains = var.availability_domain
  node_pool_size            = var.node_pool_size
  ssh_public_key            = var.public_key_path
}

module "nlb" {
  source = "./nlb"

  compartment_ocid = var.compartment_ocid
  cluster_ocid     = module.oke.cluster_ocid
  values_file      = "traefik-values.tfpl.yaml"
  traefik_template_values = {
    letsencrypt = var.cloudflare_api_key != ""
    certmanager_email_address = var.certmanager_email_address
    cloudflare_email_address  = var.cloudflare_email_address
    cloudflare_api_key        = var.cloudflare_api_key
    dashboard-url = "traefik.${var.my_domain}"
  }

  depends_on = [ module.oke ]
}
