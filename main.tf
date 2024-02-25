data "aws_caller_identity" "current" {}

terraform {
  required_version = "1.2.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.12.0"
    }
  }

  backend "s3" {
    bucket  = "YOUR-BUCKET-STATE"
    key     = "YOUR-FOLDER/terraform.tfstate"
    region  = "us-east-1" #Norte da Virgínia
    profile = "YOUR-PROFILE"
  }
}
provider "aws" {
  region  = var.region
  profile = var.profile
}