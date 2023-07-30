variable "name" {
  description = "The name of the AWS account."
  type        = string
}

variable "email" {
  description = "The email for the AWS account."
  type        = string
}

resource "aws_organizations_organization" "this" {
  aws_service_access_principals = [
    "sso.amazonaws.com",
  ]
}

resource "aws_organizations_account" "this" {
  name  = var.name
  email = var.email

  tags = {
    "terraform-module" = path.module
  }
}

# TODO Add resources from "IAM Identity center" including:
# "Administrators" Group
# Each of the Users

# Adding these will hopefully enable full configuration of the resources via terraform.
