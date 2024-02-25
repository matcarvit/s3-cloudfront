variable "region" {
  type        = string
  description = "AWS Cloud region (Required)"
  default     = "us-east-1" #Norte da Virgínia
}

#Set your credentials profile
variable "profile" {
  type        = string
  description = "AWS Credentials Profile (Required)"
  default     = "YOUR-PROFILE"
}

#Set your domain name for bucket
variable "bucket_domain_name" {
  type        = string
  description = "Domain Name for Bucket (Required with WWW)"
  default     = "www.yourdomain.com.br" #Type your domain here
}

#Set your ACM Certificate ARN
variable "acm_certificate_arn" {
  type        = string
  description = "ACM Certificate ARN (Required)"
  default     = "YOUR-SSL-ARN"
}

#Set your index document
variable "index_document" {
  type        = string
  description = "Index Document (Required)"
  default     = "index.html"
}

#Set your error document
variable "error_document" {
  type        = string
  description = "Error Document (Required)"
  default     = "error.html"
}
