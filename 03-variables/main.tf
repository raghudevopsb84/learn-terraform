variable "x" {
  default = 10
}

output "x" {
  value = var.x
}

## Variable Data types
# string
# number
# boolean
# string require double quotes, number and boolean does not require quotes.

variable "str" {
  default = "Hello"
}

variable "num" {
  default = 20
}

variable "mybool" {
  default = true
}

# When we access the variable, irrespective of type you can access it with var.var-name

# Variable requires to be in quotes if the variable is part of other characters. Also need to access that with ${var.var-nam}

output "str" {
  value = "${var.str}, Steve"
}


# Variable Types

# Normal
# List
# Map / Dict

variable "a" {
  default = "THis is a normal Variable"
}

# The values in a list can comprise multiple data types
variable "b" {
  default = [
    1,
    2,
    "abc",
    false
  ]
}

variable "c" {
  default = {
    x = 10
    y = 20
    z = "abc"
  }
}

output "b1" {
  value = var.b[0]
}

output "c1" {
  value = var.c["x"]
}


## Variable from command line
variable "cli" {
  default = 1
}

output "command-line-variable" {
  value = var.cli
}

## Variable from terraform.tfvars
variable "v1" {}
output "v1" {
  value = var.v1
}

variable "env" {}
output "env" {
  value = var.env
}











