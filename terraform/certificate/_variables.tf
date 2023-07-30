variable "url" {
  description = "The url of the website."
}

variable "zone_id" {
  description = <<-EOT
    The id of the hosted zone that the website URL is in.
    Used to verify ownership of the domains in the certificate.
  EOT
}
