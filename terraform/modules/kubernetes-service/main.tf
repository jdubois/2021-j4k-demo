
locals {
  // An Azure Container Registry name cannot contain hyphens, and is limited to 50 characters long
  azure-container-registry-name = substr(replace(var.application_name, "-", ""), 0, 46)
}

resource "azurerm_container_registry" "container-registry" {
  name                     = "acr${local.azure-container-registry-name}001"
  resource_group_name      = var.resource_group
  location                 = var.location
  admin_enabled            = true
  sku                      = "Basic"

  tags = {
    "environment" = var.environment
  }
}

resource "azurerm_kubernetes_cluster" "main" {
    name                = "aks-${var.application_name}-001"
    resource_group_name = var.resource_group
    location            = var.location
    dns_prefix          = "${var.application_name}001"

    default_node_pool {
        name       = "default"
        node_count = 2
        vm_size    = "Standard_D2_v3"
    }

    role_based_access_control {
        enabled = true
        azure_active_directory {
            managed = true
        }
    }

    identity {
        type = "SystemAssigned"
    }

    tags = {
        "environment" = var.environment
    }
}

output "client_certificate" {
    value = azurerm_kubernetes_cluster.main.kube_config.0.client_certificate
}

output "kube_config" {
    value = azurerm_kubernetes_cluster.main.kube_config_raw
}

#    "DATABASE_URL"      = var.database_url
#    "DATABASE_USERNAME" = var.database_username
#    "DATABASE_PASSWORD" = var.database_password
