resource "aws_acm_certificate" "website_cert" {
  provider          = aws.us_east_1 
  domain_name       = var.domain
  validation_method = "DNS"


  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name    = "${var.project_name}-website-cert"
    Project = var.project_name
  }
}


resource "aws_route53_record" "acm_cert_validation_record" {

  for_each = {
    for dvo in aws_acm_certificate.website_cert.domain_validation_options : dvo.domain_name => dvo
  }

  zone_id = var.zone_id
  name    = each.value.resource_record_name
  type    = each.value.resource_record_type
  records = [each.value.resource_record_value]
  ttl     = 60 

  
  #depends_on = [
  #  aws_route53_zone.delegated_subdomain_zone,
  #  aws_acm_certificate.website_cert
  #]
}


resource "aws_acm_certificate_validation" "website_cert_validation" {
  provider        = aws.us_east_1 
  certificate_arn = aws_acm_certificate.website_cert.arn


  validation_record_fqdns = [for record in aws_route53_record.acm_cert_validation_record : record.fqdn]

  depends_on = [
    aws_route53_record.acm_cert_validation_record
  ]
}