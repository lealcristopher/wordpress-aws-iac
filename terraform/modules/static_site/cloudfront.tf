resource "aws_cloudfront_distribution" "website_distribution" {
  origin {
    domain_name = aws_s3_bucket_website_configuration.test_bucket_website.website_endpoint 
    origin_id   = "S3WebsiteOrigin-${var.domain}"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1.2"] 
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "CloudFront distribution for ${var.domain}"
  default_root_object = "index.html" 

  aliases = [var.domain] 

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = "S3WebsiteOrigin-${var.domain}"

    viewer_protocol_policy = "redirect-to-https" # Redireciona HTTP para HTTPS
    min_ttl                = 0
    default_ttl            = 360 
    max_ttl                = 8640 
    compress               = true 
    
    forwarded_values {
      query_string = true 
      cookies {
        forward = "none" 
      }
    }
  }

  custom_error_response {
    error_code         = 404
    response_page_path = "/error.html"
    response_code      = 200 
  }

  restrictions {
    geo_restriction {
      restriction_type = "none" 
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = false 
    acm_certificate_arn            = aws_acm_certificate_validation.website_cert_validation.certificate_arn
    ssl_support_method             = "sni-only" 
    minimum_protocol_version       = "TLSv1.2_2019" 
  }

  tags = {
    Name    = "${var.project_name}-cloudfront-distribution"
    Project = var.project_name
  }

  depends_on = [
    aws_acm_certificate_validation.website_cert_validation
  ]
}