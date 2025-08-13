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

provider "aws" {
  alias  = "us_east_1"
  region  = var.aws_region
  profile = "aws_terraform"
}


provider "cloudflare" {
   api_token = var.cloudflare_api_token
}




#resource "random_id" "id" {
#  byte_length = 8
#}
