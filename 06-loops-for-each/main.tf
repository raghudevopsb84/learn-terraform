provider "azurerm" {
  features {}
  subscription_id = "323379f3-3beb-4865-821e-0fff68e4d4ca"
}


variable "nodes" {
  default = {
    test2 = {
      vm_size = "Standard_B2s"
    }
    test1 = {
      vm_size = "Standard_B2s"
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
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "test" {
  for_each              = var.nodes
  name                  = "${each.key}-vm"
  location              = "UK West"
  resource_group_name   = "project-setup-1"
  network_interface_ids = [azurerm_network_interface.privateip[each.key].id]
  vm_size               = each.value["vm_size"]

  delete_os_disk_on_termination = true

  storage_image_reference {
    id = "/subscriptions/323379f3-3beb-4865-821e-0fff68e4d4ca/resourceGroups/project-setup-1/providers/Microsoft.Compute/images/local-devops-practice"
  }
  storage_os_disk {
    name              = "${each.key}-vm-disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "${each.key}-vm"
    admin_username = "azuser"
    admin_password = "DevOps@123456"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
}

