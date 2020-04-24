resource "aws_s3_bucket" "html" {
  bucket        = "annas-twink-s3"
  force_destroy = true
  acl           = "private"

  lifecycle_rule {
    id      = "cleanup"
    enabled = true
    expiration {
      days = 7
    }

    noncurrent_version_expiration {
      days = 7
    }
  }

  versioning {
    enabled = true
  }
}

resource "aws_s3_bucket_object" "html" {
  key    = "index.html"
  bucket = aws_s3_bucket.html.id
  source = "index.html"
  acl    = "private"
}