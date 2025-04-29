# data block is to get the information from the provider of existing resources.
data "azurerm_resource_group" "example" {
  name = "project-setup-1"
}

output "id" {
  value = data.azurerm_resource_group.example.id
}
