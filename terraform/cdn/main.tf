resource "aws_cloudfront_origin_access_control" "this" {
  name                              = var.url
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

data "aws_cloudfront_cache_policy" "example" {
  name = "Managed-CachingOptimized"
}

resource "aws_cloudfront_distribution" "this" {
  origin {
    domain_name              = var.source_content_url
    origin_access_control_id = aws_cloudfront_origin_access_control.this.id
    origin_id                = "s3_origin"
  }

  aliases             = [var.url, "www.${var.url}"]
  default_root_object = "index.html"
  enabled             = true
  is_ipv6_enabled     = true
  price_class         = "PriceClass_All"
  retain_on_delete    = false
  wait_for_deployment = true

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    cache_policy_id        = data.aws_cloudfront_cache_policy.example.id
    compress               = true
    target_origin_id       = "s3_origin"
    viewer_protocol_policy = "redirect-to-https"
  }

  restrictions {
    geo_restriction {
      locations        = []
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn            = var.certificate_arn
    cloudfront_default_certificate = false
    minimum_protocol_version       = "TLSv1.2_2021"
    ssl_support_method             = "sni-only"
  }
}

data "aws_iam_policy_document" "origin_access" {
  statement {
    sid = "AllowCloudFrontServicePrincipalReadOnly"
    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }
    actions   = ["s3:GetObject"]
    resources = ["${var.source_content_bucket_arn}/*"]
    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = [aws_cloudfront_distribution.this.arn]
    }
  }
}

resource "aws_s3_bucket_policy" "origin_access" {
  bucket = var.source_content_bucket_id
  policy = data.aws_iam_policy_document.origin_access.json
}
