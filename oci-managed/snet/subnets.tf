resource "oci_core_subnet" "vcn_private_subnet" {
  compartment_id = var.compartment_ocid
  vcn_id         = var.vcn_id
  cidr_block     = "10.0.1.0/24"

  route_table_id             = var.vcn_nat_route_id
  security_list_ids          = [oci_core_security_list.private_subnet_sl.id]
  display_name               = "${var.cluster_name}-${var.environment}-private-subnet"
  prohibit_public_ip_on_vnic = true
}

resource "oci_core_subnet" "vcn_public_subnet" {
  compartment_id = var.compartment_ocid
  vcn_id         = var.vcn_id
  cidr_block     = "10.0.0.0/24"

  route_table_id    = var.vcn_ig_route_id
  security_list_ids = [oci_core_security_list.public_subnet_sl.id]
  display_name      = "${var.cluster_name}-${var.environment}-public-subnet"
}
