variable "compartment_ocid" {}
variable "cluster_name" {
  type = string
}
variable "environment" {
  default = "prod"
}

variable "kubernetes_version" {
  default = "v1.28.2"
}
variable "ssh_public_key" {
  type = string
}
variable "node_availability_domains" {
  type    = list(string)
  default = data.oci_identity_availability_domains.ads.availability_domains[*].name
}
variable "node_pool_size" {
  type    = number
  default = 2
}
variable "kubernetes_dashboard_enabled" {
  default = false
}
variable "tiller_enabled" {
  default = false
}

variable "vcn_id" {}
variable "vcn_public_subnet_id" {
  type = string
}
variable "vcn_private_subnet_id" {
  type = string
}

