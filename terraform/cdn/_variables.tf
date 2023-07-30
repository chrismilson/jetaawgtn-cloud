variable "url" {
  description = "The url that the site will be served on."
  type        = string
}

variable "source_content_url" {
  description = "The url to the existing content."
  type        = string
}

variable "source_content_bucket_id" {
  description = "The id of the s3 bucket containing the existing content."
  type        = string
}

variable "source_content_bucket_arn" {
  description = "The arn of the s3 bucket containing the existing content."
  type        = string
}

variable "certificate_arn" {
  description = "The arn of a TLS certificate to use as the server cert for the CDN."
  type        = string
}
