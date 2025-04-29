resource "null_resource" "test" {
  count = 10
}

# Count resource attributes are referred with resourcelabel.locallable[*].attribute
# (* denoting all values, if we want first value then [0])

output "test" {
  value = null_resource.test[*].id
}

resource "null_resource" "testx" {
}

output "testx" {
  value = null_resource.testx.id
}

## Count is not a great one to start for looping, as it has its own problems.
provider "azurerm" {
  features {}
  subscription_id = "323379f3-3beb-4865-821e-0fff68e4d4ca"
}


variable "nodes" {
  default = [
    "test2",
    "test1"
  ]
}

resource "azurerm_network_interface" "privateip" {
  count                 = length(var.nodes)
  name                  = "${var.nodes[count.index]}-ip"
  location              = "UK West"
  resource_group_name   = "project-setup-1"

  ip_configuration {
    name                          = "${var.nodes[count.index]}-ip"
    subnet_id                     = "/subscriptions/323379f3-3beb-4865-821e-0fff68e4d4ca/resourceGroups/project-setup-1/providers/Microsoft.Network/virtualNetworks/main/subnets/default"
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "test" {
  count                 = length(var.nodes)
  name                  = "${var.nodes[count.index]}-vm"
  location              = "UK West"
  resource_group_name   = "project-setup-1"
  network_interface_ids = [azurerm_network_interface.privateip[count.index].id]
  vm_size               = "Standard_B2s"

  delete_os_disk_on_termination = true

  storage_image_reference {
    id = "/subscriptions/323379f3-3beb-4865-821e-0fff68e4d4ca/resourceGroups/project-setup-1/providers/Microsoft.Compute/images/local-devops-practice"
  }
  storage_os_disk {
    name              = "${var.nodes[count.index]}-vm-disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "${var.nodes[count.index]}-vm"
    admin_username = "azuser"
    admin_password = "DevOps@123456"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
}



