resource "null_resource" "test" {}

output "test" {
  value = length(null_resource.test)
}

