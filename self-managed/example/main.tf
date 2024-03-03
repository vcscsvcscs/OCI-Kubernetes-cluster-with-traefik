variable "compartment_ocid" {}
variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "availability_domain" {}
variable "my_public_ip_cidr" {}
variable "cluster_name" {}
variable "agent_os_image_id" {}
variable "server_os_image_id" {}
variable "certmanager_email_address" {}
variable "region" {}
variable "public_key_path" {}

variable "k3s_server_pool_size" {
  default = 2
}
variable "k3s_worker_pool_size" {
  default = 2
}
variable "k3s_extra_worker_node" {
  default = false
}
variable "expose_kubeapi" {
  default = false
}
variable "environment" {
  default = "prod"
}

module "k3s_cluster" {
  # k3s_version               = "v1.23.8+k3s2" # Fix kubectl exec failure
  # k3s_version               = "v1.24.4+k3s1" # Kubernetes version compatible with longhorn
  region                    = var.region
  availability_domain       = var.availability_domain
  tenancy_ocid              = var.tenancy_ocid
  compartment_ocid          = var.compartment_ocid
  my_public_ip_cidr         = var.my_public_ip_cidr
  cluster_name              = var.cluster_name
  environment               = var.environment
  agent_os_image_id         = var.agent_os_image_id
  server_os_image_id        = var.server_os_image_id
  certmanager_email_address = var.certmanager_email_address
  certmanager_release       = "v1.13.3"
  k3s_server_pool_size      = var.k3s_server_pool_size
  k3s_worker_pool_size      = var.k3s_worker_pool_size
  k3s_extra_worker_node     = var.k3s_extra_worker_node
  expose_kubeapi            = var.expose_kubeapi
  public_key_path           = var.public_key_path
  install_longhorn          = false
  # fault_domains = [ "FAULT-DOMAIN-3" ]
  ingress_controller = "traefik2"
  source             = "../"
}

output "k3s_servers_ips" {
  value = module.k3s_cluster.k3s_servers_ips
}

output "k3s_workers_ips" {
  value = module.k3s_cluster.k3s_workers_ips
}

output "public_lb_ip" {
  value = module.k3s_cluster.public_lb_ip
}
