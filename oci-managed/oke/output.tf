output "cluster_ocid" {
  value = oci_containerengine_cluster.k8s_cluster.id
}

output "public_endpoint" {
  value = one(oci_containerengine_cluster.k8s_cluster.endpoints)
}
