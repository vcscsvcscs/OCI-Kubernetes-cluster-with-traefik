data "oci_containerengine_cluster_kube_config" "cluster_kube_config" {
    #Required
    cluster_id = var.cluster_ocid

    #Optional
    endpoint = var.cluster_public_endpoint
    token_version = "2.0.0"
}