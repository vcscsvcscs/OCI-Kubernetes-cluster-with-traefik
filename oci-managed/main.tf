
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
  depends_on       = [module.vcn]
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
  depends_on                = [module.snet]
}

module "nlb" {
  source = "./nlb"

  compartment_ocid = var.compartment_ocid
  cluster_ocid     = module.oke.cluster_ocid
  values_file      = "traefik-values.tfpl.yaml"
  traefik_template_values = {
    cloudflare_origin_certificate_pem = base64encode(file(var.cloudflare_origin_certificate_pem))
    cloudflare_origin_certificate_key = base64encode(file(var.cloudflare_origin_certificate_key))
    my_domain                         = var.my_domain
  }

  depends_on = [module.oke]
}

module "cert-manager" {
  compartment_ocid = var.compartment_ocid
  cluster_ocid     = module.oke.cluster_ocid
  count            = var.install_cert_manager ? 1 : 0
  source           = "./certmanager"

  depends_on = [module.oke]
}

module "argocd" {
  compartment_ocid = var.compartment_ocid
  cluster_ocid     = module.oke.cluster_ocid
  count            = var.install_argocd ? 1 : 0
  source           = "./argocd"

  my_domain = var.my_domain

  depends_on = [module.nlb]
}