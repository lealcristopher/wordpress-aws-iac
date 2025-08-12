variable "aws_region" {
  description = "A região AWS onde a infraestrutura será criada."
  type        = string
  default     = "us-east-1" 
}

variable "project_name" {
  description = "Nome do projeto para prefixar recursos e tags."
  type        = string
  default     = "wordpress-aws-iac" 
}


variable "cloudflare_api_token" {
  description = "Token da api cloudflare"
  type      = string
  default   = ""
}

