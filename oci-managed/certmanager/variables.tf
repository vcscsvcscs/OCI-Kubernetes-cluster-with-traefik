variable "compartment_ocid" {}
variable "environment" {
  default = "prod"
}
variable "cluster_ocid" {
  type = string
}

variable "namespace" {
  description = "Namespace to install cert-manager chart into"
  type        = string
  default     = "cert-manager"
}

variable "cert_manager_chart_version" {
  description = "Version of argocd chart to install"
  type        = string
  default     = "1.14.4" # See https://artifacthub.io/packages/helm/argo/argo-cd for latest version(s)
}

variable "trust_manager_chart_version" {
  description = "Version of argocd chart to install"
  type        = string
  default     = "0.9.1" # See https://artifacthub.io/packages/helm/argo/argo-cd for latest version(s)
}

# Helm chart deployment can sometimes take longer than the default 5 minutes
variable "timeout_seconds" {
  type        = number
  description = "Helm chart deployment can sometimes take longer than the default 5 minutes. Set a custom timeout here."
  default     = 800 # 10 minutes
}