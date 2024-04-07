terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = ">= 5.36.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.12.1"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.14.0"
    }
  }
}
