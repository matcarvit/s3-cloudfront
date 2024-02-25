#Terraform CloudFront Distribution
#---------------------------------------------------------------------------------

#CloudFront Origin Access Identity
resource "aws_cloudfront_origin_access_identity" "oai" {
  comment = "access-identity-${var.bucket_domain_name}.s3.${var.region}.amazonaws.com"
}

#CloudFront Distribution
resource "aws_cloudfront_distribution" "distribution" {
  enabled             = true
  default_root_object = var.index_document

  origin {
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.oai.cloudfront_access_identity_path
    }

    domain_name = aws_s3_bucket.www.bucket_domain_name
    origin_id   = var.bucket_domain_name
  }

  #Default values from the AWS console.
  default_cache_behavior {
    viewer_protocol_policy = "redirect-to-https"
    compress               = true
    allowed_methods        = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = var.bucket_domain_name
    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }

  aliases = [var.bucket_domain_name]

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn = var.acm_certificate_arn
    ssl_support_method  = "sni-only"
  }

  custom_error_response {
    error_caching_min_ttl = "0"
    error_code            = "404"
    response_code         = "200"
    response_page_path    = "/${var.index_document}"
  }
  custom_error_response {
    error_caching_min_ttl = "0"
    error_code            = "403"
    response_code         = "200"
    response_page_path    = "/${var.index_document}"
  }

  tags = {
    "Name"        = "CLOUDFRONT"
    "Description" = "CloudFront Distribution Resources"
    "ManagedBy"   = "Terraform Platform"
    "Account"     = "${data.aws_caller_identity.current.account_id}"
    "CreatedAt"   = formatdate("YYYY-MM-DD", timestamp())
  }
}