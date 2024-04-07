terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = ">= 5.30.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.12.1"
    }
  }
}
