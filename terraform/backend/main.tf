variable "name" {
  description = "A name to describe the environment."
  type        = string
}

resource "aws_s3_bucket" "backend" {
  bucket = "tfstate.${var.name}"

  tags = {
    "terraform-module" = path.module
  }
}
