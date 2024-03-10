data "oci_identity_availability_domains" "ads" {
  compartment_id = var.compartment_ocid
}

data "oci_core_images" "latest_image" {
  compartment_id = var.compartment_ocid
  operating_system = "Oracle Linux"
  operating_system_version = "8.8"
  shape = "VM.Standard.A1.Flex"
  filter {
    name   = "display_name"
    values = ["^.*aarch64-.*$"]
    regex = true
  }
}

data "oci_containerengine_cluster_kube_config" "cluster_kube_config" {
    #Required
    cluster_id = oci_containerengine_cluster.k8s_cluster.id
    token_version = "2.0.0"
}
