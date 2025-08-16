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


variable "root_domain_name" {
  description = "O nome do domínio raiz gerenciado pelo Cloudflare"
  type        = string
  default     = "vbvntv.org" 
}

variable "subdomain_delegated_name" {
  description = "O nome do subdomínio que será delegado para a AWS (ex: aws)"
  type        = string
  default     = "aws" 
}

locals {
  full_subdomain_name = "${var.subdomain_delegated_name}.${var.root_domain_name}"
  website_domain_name = "www.${local.full_subdomain_name}"
}


variable "cloudflare_api_token" {
  description = "Token da api cloudflare"
  type      = string
  default   = ""
}

