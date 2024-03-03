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
variable "node_image_ocid" {
  default = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaaiiymiaz2loraurxo6dgj5y4oiturf4inrkzvwimzw3d2a42kns6q"
}
variable "node_availability_domains" {
  type    = list(string)
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
