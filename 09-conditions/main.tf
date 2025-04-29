provider "azurerm" {
  features {}
  subscription_id = "323379f3-3beb-4865-821e-0fff68e4d4ca"
}


variable "nodes" {
  default = {
    test2 = {
      private_ip_address_allocation = "Static"
    }
    test1 = {
    }
  }
}

resource "azurerm_network_interface" "privateip" {
  for_each              = var.nodes
  name                  = "${each.key}-ip"
  location              = "UK West"
  resource_group_name   = "project-setup-1"

  ip_configuration {
    name                          = "${each.key}-ip"
    subnet_id                     = "/subscriptions/323379f3-3beb-4865-821e-0fff68e4d4ca/resourceGroups/project-setup-1/providers/Microsoft.Network/virtualNetworks/main/subnets/default"
    private_ip_address_allocation = length(try(each.value["private_ip_address_allocation"], "")) > 0 ? each.value["private_ip_address_allocation"] : "Dynamic"
  }
}

# condition ? true_val : false_val
# Conditions in terraform are meant to pick a value, Not meant to run a resource or not
