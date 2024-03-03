data "oci_identity_availability_domains" "ads" {
  compartment_id = var.compartment_ocid
}

data "oci_core_images" "latest_image" {
  compartment_id = var.compartment_ocid
  operating_system = "Oracle Linux"
  operating_system_version = "8.8"
  filter {
    name   = "display_name"
    values = ["^.*aarch64-.*$"]
    regex = true
  }
}
