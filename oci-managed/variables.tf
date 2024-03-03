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