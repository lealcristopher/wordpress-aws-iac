resource "aws_route53_zone" "delegated_subdomain_zone" {
  name = local.full_subdomain_name
  comment = "Managed by Terraform for ${local.full_subdomain_name}"
  tags = {
    Name    = local.full_subdomain_name
    Project = var.project_name
  }
}


resource "aws_route53_record" "example_app_record" {
  zone_id = aws_route53_zone.delegated_subdomain_zone.zone_id
  name    = "app.${local.full_subdomain_name}" # Exemplo: app.aws.xpto.com
  type    = "A"
  ttl     = 300
  records = ["192.0.2.1"] 
}


data "cloudflare_zone" "root_domain" {
  name = var.root_domain_name
}


resource "cloudflare_record" "ns_delegation" {
  count = 4  
  zone_id = data.cloudflare_zone.root_domain.id
  name    = var.subdomain_delegated_name 
  type    = "NS"
  content   = aws_route53_zone.delegated_subdomain_zone.name_servers[count.index]
  ttl     = 3600 
  proxied = false 
}


#resource "aws_route53_record" "s3_website_alias" {

#  zone_id = aws_route53_zone.delegated_subdomain_zone.zone_id 
#  name    = "www.${local.full_subdomain_name}" 
#  type    = "A" 

#  alias {
#    name                   = aws_s3_bucket_website_configuration.test_bucket_website.website_endpoint
#    zone_id                = aws_s3_bucket.test_bucket.hosted_zone_id 
#    evaluate_target_health = false 
#  }
#}


resource "aws_route53_record" "website_alias_record" {
  zone_id = aws_route53_zone.delegated_subdomain_zone.zone_id
  name    = local.website_domain_name 
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.website_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.website_distribution.hosted_zone_id
    evaluate_target_health = false
  }

  depends_on = [aws_route53_zone.delegated_subdomain_zone]
}

