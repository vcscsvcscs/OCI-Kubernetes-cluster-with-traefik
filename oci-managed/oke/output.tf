output "cluster_ocid" {
  value = oci_containerengine_cluster.k8s_cluster.id
}

output "public_endpoint" {
  value = one(oci_containerengine_cluster.k8s_cluster.endpoints)
}

resource "local_file" "oke_kubeconfig" {
  content         = data.oci_containerengine_cluster_kube_config.cluster_kube_config.content
  filename        = "${path.module}/kubeconfig"
}