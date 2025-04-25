provider "azurerm" {
  features {}
}


resource "azurerm_virtual_machine" "test" {
  name                  = "test-vm"
  location              = "UK West"
  resource_group_name   = "project-setup-1"
  network_interface_ids = ["/subscriptions/323379f3-3beb-4865-821e-0fff68e4d4ca/resourceGroups/project-setup-1/providers/Microsoft.Network/networkInterfaces/terraform-testing"]
  vm_size               = "Standard_B2ls_v2"

  delete_os_disk_on_termination = true

  storage_image_reference {
    id = "/subscriptions/323379f3-3beb-4865-821e-0fff68e4d4ca/resourceGroups/project-setup-1/providers/Microsoft.Compute/images/local-devops-practice"
  }
  storage_os_disk {
    name              = "test-vm-disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "test-vm"
    admin_username = "azuser"
    admin_password = "DevOps@123456"
  }
}

