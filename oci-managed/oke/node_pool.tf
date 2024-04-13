resource "oci_containerengine_node_pool" "k8s_node_pool" {
  cluster_id         = oci_containerengine_cluster.k8s_cluster.id
  compartment_id     = var.compartment_ocid
  kubernetes_version = var.kubernetes_version
  name               = "${var.cluster_name}-${var.environment}-arm-node-pool"
  node_config_details {
    dynamic "placement_configs" {
      for_each = var.node_availability_domains
      content {
        availability_domain = placement_configs.value
        subnet_id           = var.vcn_private_subnet_id
      }
    }
    size = var.node_pool_size
  }
  node_shape = "VM.Standard.A1.Flex"

  node_shape_config {
    memory_in_gbs = 12
    ocpus         = 2
  }

  node_source_details {
    image_id                = var.node_image_ocid
    source_type             = "image"
    boot_volume_size_in_gbs = 100
  }

  initial_node_labels {
    key   = "name"
    value = "${var.cluster_name}-${var.environment}-cluster"
  }

  ssh_public_key = file(var.ssh_public_key)
}
