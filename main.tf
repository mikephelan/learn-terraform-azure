# Configure the Azure provider
terraform {
  required_version = ">= 1.1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }
  cloud {
    organization = "mphelan-tutorial"
    workspaces {
      name = "learn-terraform-azure"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id =  var.ARM_SUBSCRIPTION_ID
  client_id       =  var.ARM_CLIENT_ID
  client_secret   =  var.ARM_CLIENT_SECRET
  tenant_id       =  var.ARM_TENANT_ID
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = "eastus2"
  tags = {
    Environment = "Terraform Getting Started"
    Team = "DevOps"
  }
}

# Create a virtual network
resource "azurerm_virtual_network" "vnet" {
  name = "myTFVnet"
  address_space = ["10.0.0.0/16"]
  location = "eastus2"
  resource_group_name = azurerm_resource_group.rg.name
}
