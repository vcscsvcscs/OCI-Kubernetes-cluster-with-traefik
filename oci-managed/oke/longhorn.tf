resource "helm_release" "longhorn" {
  count            = var.install_longhorn ? 1 : 0
  depends_on       = [oci_containerengine_cluster.k8s_cluster]
  namespace        = "longhorn-system"
  create_namespace = true
  name             = "longhorn"
  repository       = "https://charts.longhorn.io"
  chart            = "longhorn"
  version          = var.longhorn_chart_version
  cleanup_on_fail  = true

  # Helm chart deployment can sometimes take longer than the default 5 minutes
  timeout = var.timeout_seconds
}

resource "kubernetes_annotations" "patch_oci-bv" {
  depends_on  = [helm_release.longhorn]
  api_version = "storage.k8s.io/v1"
  kind        = "StorageClass"
  force       = true

  metadata {
    name = "oci-bv"
  }

  annotations = {
    "storageclass.kubernetes.io/is-default-class" = "false"
  }
}
