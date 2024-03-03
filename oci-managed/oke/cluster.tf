resource "oci_containerengine_cluster" "k8s_cluster" {
  compartment_id     = var.compartment_ocid
  kubernetes_version = var.kubernetes_version
  name               = "${var.cluster_name}-${var.environment}-cluster"
  vcn_id             = var.vcn_id

  endpoint_config {
    is_public_ip_enabled = true
    subnet_id            = var.vcn_public_subnet_id
  }

  options {
    add_ons {
      is_kubernetes_dashboard_enabled = var.kubernetes_dashboard_enabled
      is_tiller_enabled               = var.tiller_enabled
    }
    kubernetes_network_config {
      pods_cidr     = "10.244.0.0/16"
      services_cidr = "10.96.0.0/16"
    }
    service_lb_subnet_ids = [var.vcn_public_subnet_id]
  }
}
