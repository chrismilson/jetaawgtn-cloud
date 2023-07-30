# Backend

These resources are only required to store the terraform state. You can read about terraform remote state [here](https://developer.hashicorp.com/terraform/language/state). We use the "s3" (aws) terraform backend, since our actual resources are in AWS already. You can read about the specifics of the AWS terraform remote backend [here](https://developer.hashicorp.com/terraform/language/settings/backends/s3).
