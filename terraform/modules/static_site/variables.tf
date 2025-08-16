variable "aws_region" {
  description = "A região AWS onde a infraestrutura será criada."
  type        = string
  default     = "us-east-1" 
}


variable "project_name" {
  description = "Nome do projeto para prefixar recursos e tags."
  type        = string
  default     = "default-project" 
}

variable "domain" {
	default = "example.com"
}

variable "zone_id" {
  default = ""
}

variable "subdomain_zone" {
  default = ""
}