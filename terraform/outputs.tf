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