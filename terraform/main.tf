terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" 
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region  = var.aws_region
  profile = "aws_terraform"
}


provider "cloudflare" {
   api_token = var.cloudflare_api_token
}


# --- Saídas Úteis ---

# Output do endpoint do website S3 para acesso direto
output "test_bucket_website_endpoint" {
  description = "Endpoint do website S3 para o bucket de teste"
  value       = aws_s3_bucket_website_configuration.test_bucket_website.website_endpoint
}

# Output da URL do bucket (útil para uploads via CLI)
output "test_bucket_url" {
  description = "URL do bucket S3 de teste"
  value       = "s3://${aws_s3_bucket.test_bucket.id}"
}

# Output do nome do bucket


resource "random_id" "id" {
  byte_length = 8
}
