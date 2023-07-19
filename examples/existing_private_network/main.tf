terraform {
  required_version = ">= 1.0.0, < 2.0.0"

  backend "azurerm" {
    resource_group_name  = "az-eastus-weka-tf-state-rg"
    storage_account_name = "azeastuswekatfstate01"
    container_name       = "azeastuswekatfstatecon01"
    key                  = "jacton.tfstate"
    use_azuread_auth     = true
    subscription_id      = "13b706d3-f7a2-4e89-91d3-921288c68091"
    tenant_id            = "8242a0a9-c415-4206-be39-06637ad2817a"
  }

  # required_providers {
  #   azurerm = {
  #     source  = "hashicorp/azurerm"
  #     version = ">= 3.9.0, < 3.52.0"
  #   }
  # }
}

# provider "azurerm" {
#   subscription_id = "13b706d3-f7a2-4e89-91d3-921288c68091"

#   features {}
# }

provider "azurerm" {
  subscription_id = "13b706d3-f7a2-4e89-91d3-921288c68091"
  partner_id      = "f13589d1-f10d-4c3b-ae42-3b1a8337eaf1"
  features {
  }
}

module "create-network" {
  source            = "../../modules/create_networks"
  prefix            = var.prefix
  rg_name           = var.rg_name
  vnet_name         = var.vnet_name
  subnet_name       = var.subnet_name
  private_network   = var.private_network
}

module "deploy-weka" {
  source                = "../.."
  prefix                = var.prefix
  rg_name               = var.rg_name
  vnet_name             = module.create-network.vnet-name
  vnet_rg_name          = module.create-network.vnet_rg_name
  subnet_name           = module.create-network.subnets-name
  sg_id                 = module.create-network.sg-id
  subnet_delegation     = var.subnet_delegation
  cluster_name          = var.cluster_name
  apt_repo_url          = var.apt_repo_url
  private_network       = var.private_network
  install_weka_url      = var.install_weka_url
  instance_type         = var.instance_type
  cluster_size          = var.cluster_size
  set_obs_integration   = var.set_obs_integration
  tiering_ssd_percent   = var.tiering_ssd_percent
  subscription_id       = "13b706d3-f7a2-4e89-91d3-921288c68091"
  private_dns_zone_name = module.create-network.private-dns-zone-name
  depends_on            = [module.create-network]
}