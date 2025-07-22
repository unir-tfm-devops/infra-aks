# Azure AKS Infrastructure

This repository contains Terraform configurations for managing Azure Kubernetes Service (AKS) clusters. It provides a complete infrastructure setup for container orchestration with ArgoCD for GitOps deployment management.

## 🏗️ Infrastructure Overview

This Terraform project manages:

- **Azure AKS Cluster**: Kubernetes cluster with managed node pools
- **Azure Resource Group**: Centralized resource management
- **ArgoCD Deployment**: GitOps continuous deployment platform
- **Node Pools**: Managed AKS node pools for workload execution
- **Modular Design**: Reusable AKS module for scalable infrastructure

## 📁 Project Structure

```
infra-aks/
├── main.tf               # AKS cluster configuration
├── argocd.tf             # ArgoCD Helm deployment
├── providers.tf          # Azure, Kubernetes, and Helm provider configuration
├── backend.tf            # Terraform backend configuration
└── helm-values/
    └── argocd-values.yaml # ArgoCD Helm chart values
```

## 🚀 Features

### AKS Cluster
- **Managed Kubernetes**: Azure-managed Kubernetes control plane
- **System-Assigned Identity**: Secure cluster access with Azure managed identity
- **Node Pools**: Managed node pools with Standard_B2s instances
- **Kubernetes Version**: Running Kubernetes 1.32
- **Location**: Deployed in East US region

### Azure Infrastructure
- **Resource Group**: Centralized resource management in `unir-tfm-devops-rg`
- **Managed Identity**: System-assigned identity for secure operations
- **State Management**: Azure Storage backend for Terraform state
- **Network Integration**: Azure-managed networking for the cluster

### ArgoCD Integration
- **GitOps Platform**: Automated deployment from Git repositories
- **Helm Chart Management**: Deployed using Helm with custom values
- **ChartMuseum Integration**: Connected to external Helm chart repository
- **ClusterIP Service**: Internal service access for ArgoCD server

## 🔧 Prerequisites

- **Terraform** >= 1.0
- **Azure CLI** configured with appropriate credentials
- **kubectl** for Kubernetes cluster interaction
- **helm** for Helm chart management
- **Azure Storage Account**: Configured storage account for Terraform state

## 📋 Requirements

### Azure Requirements
- Azure subscription with appropriate permissions for:
  - AKS cluster creation and management
  - Resource group management
  - Storage account access for Terraform state
  - Virtual machine management for node pools

### Terraform Providers
- `hashicorp/azurerm` ~> 3.110.0 - Azure provider
- `hashicorp/helm` ~> 2.17.0 - Helm provider

## 🚀 Quick Start

### 1. Initialize Terraform
```bash
terraform init
```

### 2. Review the Plan
```bash
terraform plan
```

### 3. Apply the Configuration
```bash
terraform apply
```

### 4. Configure kubectl
After successful deployment, configure kubectl to access your cluster:
```bash
az aks get-credentials --resource-group unir-tfm-devops-rg --name unir-tfm-aks-cluster
```

### 5. Access ArgoCD
Get the ArgoCD admin password and access the UI:
```bash
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
kubectl port-forward svc/argocd-server -n argocd 8080:443
```

## 🔐 Security Considerations

### Cluster Security
- **System-Assigned Identity**: Uses Azure managed identity for secure operations
- **RBAC**: Role-based access control enabled
- **Network Security**: Azure-managed networking with proper isolation
- **Node Security**: Managed node pools with Azure security features

### Production Security Recommendations

1. **Private Clusters**: Consider using private AKS clusters for enhanced security
2. **Network Policies**: Implement network policies for pod-to-pod communication
3. **Azure AD Integration**: Enable Azure AD integration for user authentication
4. **Pod Security**: Implement pod security standards and policies
5. **Secrets Management**: Use Azure Key Vault for secrets management
6. **Monitoring**: Enable Azure Monitor for comprehensive monitoring

## 📊 Outputs

The AKS infrastructure provides the following outputs:

| Output | Description |
|--------|-------------|
| `cluster_name` | The name of the AKS cluster |
| `cluster_endpoint` | The endpoint for the AKS cluster API server |
| `resource_group_name` | The name of the Azure resource group |

## 🧹 Cleanup

To destroy all resources:
```bash
terraform destroy
```

⚠️ **Warning**: This will permanently delete the AKS cluster and all associated resources.

## 🔧 Customization

### Cluster Configuration
Modify `main.tf` to adjust:
- Cluster version and name
- Node pool instance types and sizing
- Location and resource group settings
- Identity and RBAC settings

### ArgoCD Configuration
Modify `helm-values/argocd-values.yaml` to adjust:
- Service type and configuration
- Repository connections
- Reconciliation settings
- RBAC and security settings

## 📝 Notes

- **State Management**: Uses Azure Storage backend for remote state storage
- **Region**: Configured for East US region
- **Resource Group**: All resources deployed in `unir-tfm-devops-rg`
- **Node Pools**: Currently configured with Standard_B2s instances
- **ArgoCD**: Deployed with ClusterIP service type for internal access
- **ChartMuseum**: Connected to external Helm repository at 3.238.99.68

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test with `terraform plan`
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.
