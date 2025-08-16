

output "distribution_domain_name" {
	value =  aws_cloudfront_distribution.website_distribution.domain_name
}

output "hosted_zone_id" {
	value = aws_cloudfront_distribution.website_distribution.hosted_zone_id
}

output "bucket_name" {
  description = "Nome do bucket S3 de teste criado."
  value       = aws_s3_bucket.test_bucket.id
}

output "bucket_website_domain" {
   description = ""
   value = aws_s3_bucket_website_configuration.test_bucket_website.website_domain
}

output "bucket_website_endpoint" {
  description = "Endpoint do website S3 para o bucket de teste"
  value       = aws_s3_bucket_website_configuration.test_bucket_website.website_endpoint
}

output "bucket_url" {
  description = "URL do bucket S3 de teste"
  value       = "s3://${aws_s3_bucket.test_bucket.id}"
}