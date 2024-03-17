# OCI Kubernetes cluster with traefik
 This repo has 2 kind of cluster setup for kubernetes, one is oci managed (OKE), the other one is the self managed cluster.

## OCI managed cluster (OKE)

This Terraform configuration sets up an Oracle Cloud Infrastructure (OCI) cluster with various components including a virtual cloud network (VCN), subnets, Oracle Kubernetes Engine (OKE) cluster, Service Networking (SNET), Network Load Balancer (NLB), and optionally installs ArgoCD. This setup assumes you use cloudflare and you want a wildcard domain dns setup for your cluster with strict https encryption setup with traefik.

### Prerequisites

Before you begin, ensure you have the following:

- Access to an Oracle Cloud Infrastructure (OCI) tenancy.
- Properly configured authentication with necessary API credentials.
- Terraform CLI installed locally.

#### Variables

You need to provide values for the following variables:

- ```compartment_ocid: The OCID (Oracle Cloud Identifier) of the compartment where resources will be created.```
- ```tenancy_ocid: The OCID of your OCI tenancy.```
- ```user_ocid: The OCID of the user.```
- ```fingerprint: The fingerprint of the public key uploaded to OCI.```
- ```private_key_path: The file path to the private key used for API authentication.```
- ```availability_domain: The availability domain where resources will be provisioned.```
- ```cluster_name: The name of the OCI cluster.```
- ```cloudflare_api_email: Email associated with Cloudflare API.```
- ```cloudflare_api_key: API key for Cloudflare.```
- ```cloudflare_origin_certificate_pem: PEM-formatted string of Cloudflare origin certificate.```
- ```cloudflare_origin_certificate_key: Private key associated with Cloudflare origin certificate.```
- ```my_domain: Your domain name.```
- ```install_argocd: Boolean flag indicating whether to install ArgoCD.```
- ```install_cert_manager: Boolean flag indicating whether to install cert-manager.```
- ```region: OCI region where resources will be created.```
- ```public_key_path: File path to the SSH public key.```
- ```node_pool_size: Number of worker nodes in the Kubernetes cluster.```
- ```environment: Deployment environment, e.g., "prod", "dev", etc.```

### Modules
#### VCN (Virtual Cloud Network)

This module creates a VCN with specified configurations.
#### SNET (Service Networking)

This module configures Service Networking in the VCN.
#### OKE (Oracle Kubernetes Engine)

This module sets up an OKE cluster within the VCN.
#### NLB (Network Load Balancer)

This module provisions a traefik2 Network Load Balancer for the cluster.
#### ArgoCD

This module installs and configures ArgoCD on the cluster, if enabled.
#### Cert-Manager

This module if enabled installs cert-manager on the cluster and sets up a ClusterIssuer self signed certificate issuer for pod to pod communication.

### How to run
Ensure you have set up your Terraform environment and configured the necessary variables.
    Run ```terraform init``` to initialize the directory.
    Run ```terraform plan -out tf.plan``` to see the execution plan.
    Run ```terraform apply tf.plan``` to apply the changes and provision the resources.