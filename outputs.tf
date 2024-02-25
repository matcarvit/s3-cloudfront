output "bucket_s3_name" {
  value = aws_s3_bucket.www.bucket
}

output "bucket_s3_website_endpoint" {
  value = aws_s3_bucket.www.website_endpoint
}

output "cloudfront_distribution_arn" {
  value = aws_cloudfront_distribution.distribution.arn
}

output "cloudfront_distribution_domain_name" {
  value = aws_cloudfront_distribution.distribution.domain_name
}