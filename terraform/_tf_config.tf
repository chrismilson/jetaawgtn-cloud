terraform {
  # Since this terraform also tracks the resources required for the remote state,
  # you would need to use a local state initially to create those resources first
  # before copying the state into the newly created resources.
  # Since those resources have already been created, you don't need to worry about it!
  # backend "local" {}

  # This is the configuration for the remote resources that will store the terraform state.
  # You can learn more about them in ./backend.tf
  backend "s3" {
    bucket = "tfstate.jetaawgtn.org.nz"
    key    = "terraform.tfstate"
    region = "ap-southeast-2"
  }

  # This is the version of terraform you will need to interact with this configuration.
  required_version = "1.5"

  # These are the version of the different terraform providers we need to managed this configuration.
  # Terraform will automatically download them on `init`, so you don't need to download them yourself.
  required_providers {
    # The "aws" provider packages the information that terraform needs to know how to create "aws" resources.
    # You can read the aws terraform provider documentation [here](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  # This is the account id of the jetaawellington aws account
  allowed_account_ids = ["905493318373"]

  # This is the Sydney region - it is nice and close to New Zealand
  region = "ap-southeast-2"

  # These tags will be set on all resources.
  # Hopefully they will help you discover the code if you are looking at the resources in the console.
  default_tags {
    tags = {
      "terraform-repository" = "https://github.com/chrismilson/jetaawgtn-cloud"
      "created-by"           = "terraform"
    }
  }
}

# Some resources are global and need to be created in the "us-east-1" region instead.
provider "aws" {
  alias               = "global"
  region              = "us-east-1"
  allowed_account_ids = ["905493318373"]

  default_tags {
    tags = {
      "terraform-repository" = "https://github.com/chrismilson/jetaawgtn-cloud"
      "created-by"           = "terraform"
    }
  }
}
