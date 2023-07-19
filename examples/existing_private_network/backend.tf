terraform {
  required_version = ">= 1.0.0, < 2.0.0"

  backend "azurerm" {
    resource_group_name  = "az-eastus-weka-tf-state-rg"
    storage_account_name = "azeastuswekatfstate01"
    container_name       = "azeastuswekatfstatecon01"
    key                  = "wekafull.tfstate"
    use_azuread_auth     = true
    subscription_id      = "13b706d3-f7a2-4e89-91d3-921288c68091"
    tenant_id            = "8242a0a9-c415-4206-be39-06637ad2817a"
  }
}
