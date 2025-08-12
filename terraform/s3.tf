
resource "aws_s3_bucket" "test_bucket" {
  bucket = "www.${local.full_subdomain_name}"

  tags = {
    Name        = "${var.project_name}-test-bucket"
    Environment = "Dev"
    ManagedBy   = "Terraform"
    Project     = var.project_name
  }
}


resource "aws_s3_bucket_website_configuration" "test_bucket_website" {

  bucket = aws_s3_bucket.test_bucket.id 

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html" 
  }

}

resource "aws_s3_bucket_policy" "test_bucket_policy" {

  bucket = aws_s3_bucket.test_bucket.id 

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "PublicReadGetObject",
        Effect    = "Allow",
        Principal = "*", 
        Action    = ["s3:GetObject"], 
        Resource  = ["${aws_s3_bucket.test_bucket.arn}/*"] 
      },
    ]
  })
}


resource "aws_s3_bucket_public_access_block" "test_bucket_public_access_block" {

  bucket = aws_s3_bucket.test_bucket.id

  block_public_acls = false
  block_public_policy = false
  ignore_public_acls = false
  
  restrict_public_buckets = false
}
