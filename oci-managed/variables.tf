variable "compartment_ocid" {}
variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "availability_domain" {}
variable "cluster_name" {}

variable "certmanager_email_address" {
  type = string
}
variable "cloudflare_email_address" {
  type = string
}
variable "cloudflare_api_key" {
  type = string
}
variable "my_domain" {
  type = string
}

variable "region" {}
variable "public_key_path" {}

variable "node_pool_size" {
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