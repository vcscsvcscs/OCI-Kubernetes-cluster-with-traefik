variable "compartment_ocid" {}
variable "vcn_id" {}
variable "vcn_nat_route_id" {
  type = string
}
variable "vcn_ig_route_id" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "environment" {
  default = "prod"
}
