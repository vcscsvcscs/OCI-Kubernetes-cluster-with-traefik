variable "compartment_ocid" {}
variable "cluster_name" {
  type = string
}
variable "environment" {
  default = "prod"
}

variable "kubernetes_version" {
  default = "v1.29.1"
}
variable "ssh_public_key" {
  type = string
}
variable "node_image_ocid" {
  default = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaa3mctwlkbkaj76pnlrmdr7w6dd4frkrhuqrdadpq4g67kh5gqbn3q"
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

variable "install_longhorn" {
  default = true
}
variable "longhorn_chart_version" {
  default = "1.6.1"
}
# Helm chart deployment can sometimes take longer than the default 5 minutes
variable "timeout_seconds" {
  type        = number
  description = "Helm chart deployment can sometimes take longer than the default 5 minutes. Set a custom timeout here."
  default     = 800 # 10 minutes
}

variable "vcn_id" {}
variable "vcn_public_subnet_id" {
  type = string
}
variable "vcn_private_subnet_id" {
  type = string
}
