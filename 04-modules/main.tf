# A group of resources to be created once is called as module. Equivalent to function in shell. Role in Ansible

# Module sources - https://developer.hashicorp.com/terraform/language/modules/sources


module "sample1" {
  source = "./sample"
  x= 100
}

module "sample2" {
  source = "./sample"
  x= var.x
}

variable "x" {
  default = 100
}
