#### https://developer.hashicorp.com/terraform/language/resources/provisioners/syntax

Provisioners are used to execute certain commands on remote server or local server after provisioning the resource.
Any provisioner change will not be detected by resource after resource creation. Hence, we mostly decouple the provisioner from main resource to null resource.
Null resource has a criteria to change the behaviour of when to run and re-run.
