#Terraform S3 Bucket WebSite
#---------------------------------------------------------------------------------

#www S3 Bucket
resource "aws_s3_bucket" "www" {
  bucket = var.bucket_domain_name
  tags = {
    "Name"        = "S3"
    "Description" = "Bucket S3 Resources"
    "ManagedBy"   = "Terraform Platform"
    "Account"     = "${data.aws_caller_identity.current.account_id}"
    "CreatedAt"   = formatdate("YYYY-MM-DD", timestamp())
  }
}

#S3 Bucket Website Configuration
resource "aws_s3_bucket_website_configuration" "www" {
  bucket = aws_s3_bucket.www.id

  index_document {
    suffix = var.index_document
  }

  error_document {
    key = var.index_document
  }
}

#S3 Bucket Block Public Access (Enable All)
resource "aws_s3_bucket_public_access_block" "www" {
  bucket                  = aws_s3_bucket.www.id
  restrict_public_buckets = true
  block_public_policy     = true
  block_public_acls       = true
  ignore_public_acls      = true
}

#S3 Bucket Cors Rules
resource "aws_s3_bucket_cors_configuration" "www" {
  bucket = aws_s3_bucket.www.bucket

  cors_rule {
    allowed_headers = ["Authorization", "Content-Length"]
    allowed_methods = ["PUT", "POST", "GET", "DELETE"]
    allowed_origins = ["*"]
    expose_headers  = []
    max_age_seconds = 3000
  }
}

#Import S3 IAM Policy
data "aws_iam_policy_document" "s3_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.www.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.oai.iam_arn]
    }
  }
}

#Policy Attachment
resource "aws_s3_bucket_policy" "policy" {
  bucket = aws_s3_bucket.www.id
  policy = data.aws_iam_policy_document.s3_policy.json
}

#S3 Bucket - Encrypt
resource "aws_s3_bucket_server_side_encryption_configuration" "s3" {
  bucket = aws_s3_bucket.www.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}