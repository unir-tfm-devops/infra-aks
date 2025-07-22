data "azurerm_container_registry" "acr" {
  name                = "unirtfmdevops"
  resource_group_name = "unir-tfm-devops-rg"
}

module "aks" {
  source  = "Azure/aks/azurerm"
  version = "~> 9.0.0"

  resource_group_name = "unir-tfm-devops-rg"
  cluster_name        = "unir-tfm-aks-cluster"
  location            = "East US"

  kubernetes_version = "1.32"
  prefix             = "unir-tfm"

  agents_size  = "Standard_B2s"
  agents_count = 2

  node_pools = {
    default = {
      name       = "default"
      vm_size    = "Standard_B2s"
      node_count = 2
      mode       = "User"
    }
  }

  identity_type                     = "SystemAssigned"
  rbac_aad                          = false
  role_based_access_control_enabled = false
  log_analytics_workspace_enabled   = false

  attached_acr_id_map = {
    "unirtfmdevops" = data.azurerm_container_registry.acr.id
  }
}
