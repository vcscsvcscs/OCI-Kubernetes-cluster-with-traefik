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
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.14.0"
    }
  }
}

provider "oci" {
  tenancy_ocid           = var.tenancy_ocid
  user_ocid              = var.user_ocid
  private_key_path       = pathexpand(var.private_key_path)
  fingerprint            = var.fingerprint
  region                 = var.region
  retry_duration_seconds = 120
}

provider "helm" {
  kubernetes {
    config_path = "oke/kubeconfig"
  }
}

provider "cloudflare" {
  email   = var.cloudflare_api_email
  api_key = var.cloudflare_api_key
}

provider "kubectl" {
  config_path = "oke/kubeconfig"
}