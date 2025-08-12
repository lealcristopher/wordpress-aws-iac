# Se você já tem a definição do bucket, mantenha-a.
# Apenas a incluo aqui para contexto.

	

resource "aws_s3_bucket" "test_bucket" {
  bucket = "www.${local.full_subdomain_name}"

  tags = {
    Name        = "${var.project_name}-test-bucket"
    Environment = "Dev"
    ManagedBy   = "Terraform"
    Project     = var.project_name
  }
}



# --- Novos Recursos para Configuração de Website ---

# 1. Configuração do Website Estático para o bucket 'test_bucket'
resource "aws_s3_bucket_website_configuration" "test_bucket_website" {
  bucket = aws_s3_bucket.test_bucket.id # Referencia o ID do bucket existente

  index_document {
    suffix = "index.html" # Documento padrão quando a URL do bucket é acessada
  }

  error_document {
    key = "error.html" # Documento exibido em caso de erro 4xx
  }

  # Opcional: Se você quiser redirecionar todo o tráfego para outro domínio
  # redirect_all_requests_to {
  #   host_name = "www.example.com"
  #   protocol  = "https"
  # }

  # Opcional: Regras de roteamento para redirecionamentos mais complexos
  # routing_rule {
  #   condition {
  #     key_prefix_equals = "docs/"
  #   }
  #   redirect {
  #     host_name = "docs.example.com"
  #   }
  # }
}

# 2. Política do Bucket S3 para permitir acesso público de leitura (GetObject)
resource "aws_s3_bucket_policy" "test_bucket_policy" {
  bucket = aws_s3_bucket.test_bucket.id # Referencia o ID do bucket

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "PublicReadGetObject",
        Effect    = "Allow",
        Principal = "*", # Permite acesso de qualquer entidade
        Action    = ["s3:GetObject"], # Ação permitida: ler objetos
        Resource  = ["${aws_s3_bucket.test_bucket.arn}/*"] # Aplica-se a todos os objetos no bucket
      },
    ]
  })
}

# 3. Bloco de Acesso Público ao Bucket S3
# Este recurso é CRÍTICO para permitir que a política e ACLs públicas funcionem.
# Ele desabilita os bloqueios de acesso público padrão da AWS para o bucket.
resource "aws_s3_bucket_public_access_block" "test_bucket_public_access_block" {
  bucket = aws_s3_bucket.test_bucket.id

  # `block_public_acls` = false : Permite que as ACLs públicas sejam usadas (como "public-read" na criação do bucket, se você adicionar)
  block_public_acls = false
  # `block_public_policy` = false : Permite que políticas de bucket públicas sejam aplicadas
  block_public_policy = false
  # `ignore_public_acls` = false : Não ignora ACLs públicas existentes
  ignore_public_acls = false
  # `restrict_public_buckets` = false : Não restringe buckets com políticas públicas
  restrict_public_buckets = false
}
