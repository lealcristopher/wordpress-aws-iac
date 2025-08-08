terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" 
    }
  }
}

provider "aws" {
  region  = var.aws_region
  profile = "aws_terraform"
}

resource "aws_s3_bucket" "test_bucket" {
  bucket = "${var.project_name}-test-bucket-${random_id.id.hex}"

  tags = {
    Name        = "${var.project_name}-test-bucket"
    Environment = "Dev"
    ManagedBy   = "Terraform"
    Project     = var.project_name
  }
}

resource "random_id" "id" {
  byte_length = 8
}