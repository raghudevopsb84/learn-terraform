provider "vault" {
  address = "http://vault.rdevopsb84.online:8200"
  token = var.token
}

variable "token" {}

data "vault_generic_secret" "secret" {
  path = "demo/ssh"
}


