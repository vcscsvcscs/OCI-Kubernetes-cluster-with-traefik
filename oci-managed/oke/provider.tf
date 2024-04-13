terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = ">= 5.3.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.12.1"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.28.0"
    }
  }
}
