output "test_bucket_name" {
  description = "Nome do bucket S3 de teste criado."
  value       = aws_s3_bucket.test_bucket.id
}

output "aws_account_id" {
  description = "ID da conta AWS que está sendo usada."
  value       = data.aws_caller_identity.current.account_id
}

output "aws_user_arn" {
  description = "ARN do usuário AWS que está sendo usado."
  value       = data.aws_caller_identity.current.arn
}

data "aws_caller_identity" "current" {}


output "aws_delegated_subdomain_name_servers" {
  description = "Name Servers gerados pela AWS para o subdomínio delegado."
  value       = aws_route53_zone.delegated_subdomain_zone.name_servers
}


output "delegated_subdomain_fqdn" {
  description = "O nome de domínio totalmente qualificado do subdomínio delegado."
  value       = local.full_subdomain_name
}

output "bucket_domain" {
   description = ""
   value = aws_s3_bucket_website_configuration.test_bucket_website.website_domain
}



output "test_bucket_website_endpoint" {
  description = "Endpoint do website S3 para o bucket de teste"
  value       = aws_s3_bucket_website_configuration.test_bucket_website.website_endpoint
}

output "test_bucket_url" {
  description = "URL do bucket S3 de teste"
  value       = "s3://${aws_s3_bucket.test_bucket.id}"
}


