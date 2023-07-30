locals {
  url = "jetaawgtn.org.nz"
}

module "account" {
  source = "./account"
  name   = "jetaawellington"
  email  = "jetaawellington@gmail.com"
}

module "backend" {
  source = "./backend"
  name   = local.url
}

resource "aws_route53_zone" "this" {
  name = local.url

  tags = {
    "terraform-module" = path.module
  }

  lifecycle {
    prevent_destroy = true
  }
}

module "website" {
  source = "./website"
  url    = local.url
}

module "certificate" {
  providers = { aws = aws.global }
  source    = "./certificate"
  url       = local.url
  zone_id   = aws_route53_zone.this.id
}

module "cdn" {
  source = "./cdn"

  url                       = local.url
  source_content_url        = module.website.bucket_regional_domain_name
  source_content_bucket_id  = module.website.bucket_id
  source_content_bucket_arn = module.website.bucket_arn
  certificate_arn           = module.certificate.certificate_arn
}
