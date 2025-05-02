provider "vault" {
  address = "http://vault.rdevopsb84.online:8200"
  token = var.token
}

variable "token" {}

data "vault_generic_secret" "secret" {
  path = "demo/ssh"
}

resource "local_file" "foo" {
  content  = jsonencode(data.vault_generic_secret.secret.data)
  filename = "/tmp/vault"
}

resource "local_file" "foo1" {
  content  = data.vault_generic_secret.secret.data["password"]
  filename = "/tmp/vault-pass"
}




