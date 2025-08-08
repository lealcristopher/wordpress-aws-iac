# Use uma imagem Python slim como base para um contêiner leve
FROM python:3.9-slim-bullseye

# Define variáveis de ambiente para instalações não interativas e para Python
ENV DEBIAN_FRONTEND=noninteractive \
    PIP_NO_CACHE_DIR=off \
    PIP_DISABLE_PIP_VERSION_CHECK=on \
    PYTHONUNBUFFERED=1

# Instala dependências de sistema necessárias (git, ssh-client, unzip, wget, ca-certificates)
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        git \
        ssh-client \
        unzip \
        wget \
        ca-certificates \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# --- Instalação do Terraform ---
# Use uma versão específica do Terraform para garantir reprodutibilidade
ARG TERRAFORM_VERSION="1.8.5"
RUN wget -q https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -O /tmp/terraform.zip \
    && unzip /tmp/terraform.zip -d /usr/local/bin \
    && rm /tmp/terraform.zip

# --- Instalação do Ansible e AWS SDK ---
# Instala Ansible e o AWS SDK para Python (boto3 e botocore), que são requisitos da coleção amazon.aws
RUN pip install --no-cache-dir ansible "boto3>=1.15.0" "botocore>=1.18.0"

# Instala a coleção Ansible Amazon AWS (mantemos, pois outros módulos podem ser usados)
RUN ansible-galaxy collection install amazon.aws

# === NOVO: Instala a coleção Community AWS para o módulo s3_website ===
RUN ansible-galaxy collection install community.aws

# Define o diretório de trabalho padrão dentro do contêiner
WORKDIR /app

# Opcional: Define um usuário não-root para execução (melhor prática de segurança)
# RUN useradd -m ansibleuser && chown -R ansibleuser:ansibleuser /app
# USER ansibleuser
