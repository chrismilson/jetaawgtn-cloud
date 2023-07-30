locals {
  # The relative path from here to the website content
  relative_path = "../../website-content"
}

resource "aws_s3_object" "index_page" {
  for_each    = fileset("${path.module}/${local.relative_path}", "*")
  bucket      = aws_s3_bucket.this.id
  key         = each.key
  source      = "${path.module}/${local.relative_path}/${each.key}"
  source_hash = filemd5("${path.module}/${local.relative_path}/${each.key}")

  tags = {
    "terraform-module" = path.module
  }
}
