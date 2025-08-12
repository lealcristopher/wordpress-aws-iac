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
}

# -----------------------------------------------------------------------------
# 3. Recursos AWS: Hosted Zone e Registros
# -----------------------------------------------------------------------------

# Cria a Hosted Zone pública para o subdomínio na AWS Route 53
resource "aws_route53_zone" "delegated_subdomain_zone" {
  name = local.full_subdomain_name
  comment = "Managed by Terraform for ${local.full_subdomain_name}"
}

# Exemplo: Cria um registro A para um serviço dentro do subdomínio delegado
# Substitua '192.0.2.1' pelo IP do seu recurso AWS (e.g., IP de um Load Balancer ou EC2)
resource "aws_route53_record" "example_app_record" {
  zone_id = aws_route53_zone.delegated_subdomain_zone.zone_id
  name    = "app.${local.full_subdomain_name}" # Exemplo: app.aws.xpto.com
  type    = "A"
  ttl     = 300
  records = ["192.0.2.1"] 
}

# -----------------------------------------------------------------------------
# 4. Recursos Cloudflare: Delegação NS
# -----------------------------------------------------------------------------

# Data Source para obter o ID da Zona do Cloudflare para o domínio raiz
data "cloudflare_zone" "root_domain" {
  name = var.root_domain_name
}

# Cria os registros NS no Cloudflare, um para cada Name Server da AWS Route 53.
# Isso delega o controle do subdomínio para a AWS.
resource "cloudflare_record" "ns_delegation" {
  count = 4  
  zone_id = data.cloudflare_zone.root_domain.id
  name    = var.subdomain_delegated_name # 'aws' para 'aws.xpto.com'
  type    = "NS"
  content   = aws_route53_zone.delegated_subdomain_zone.name_servers[count.index]
  ttl     = 3600 # TTL recomendado para registros NS
  proxied = false # Registros NS não devem ser 'proxied' pelo Cloudflare
}


resource "aws_route53_record" "s3_website_alias" {

  zone_id = aws_route53_zone.delegated_subdomain_zone.zone_id 
  name    = "www.${local.full_subdomain_name}" 
  type    = "A" 

  alias {
    name                   = aws_s3_bucket_website_configuration.test_bucket_website.website_endpoint
    zone_id                = aws_s3_bucket.test_bucket.hosted_zone_id 
    evaluate_target_health = false 
  }
}




# -----------------------------------------------------------------------------
# 5. Saídas (Outputs)
# -----------------------------------------------------------------------------

# Mostra os Name Servers gerados pela AWS para o subdomínio
output "aws_delegated_subdomain_name_servers" {
  description = "Name Servers gerados pela AWS para o subdomínio delegado."
  value       = aws_route53_zone.delegated_subdomain_zone.name_servers
}

# Mostra o FQDN completo do subdomínio delegado
output "delegated_subdomain_fqdn" {
  description = "O nome de domínio totalmente qualificado do subdomínio delegado."
  value       = local.full_subdomain_name
}

output "bucket_domain" {
   description = ""
   value = aws_s3_bucket_website_configuration.test_bucket_website.website_domain
}


