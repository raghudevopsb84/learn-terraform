resource "null_resource" "test" {}

terraform {
  backend "azurerm" {
    use_cli              = true
    #tenant_id            = "00000000-0000-0000-0000-000000000000"
    subscription_id      = "323379f3-3beb-4865-821e-0fff68e4d4ca"
    resource_group_name  = "project-setup-1"
    storage_account_name = "rdevopsb84tfstates"
    container_name       = "roboshop-state-files"
    key                  = "test.terraform.tfstate"
  }
}


