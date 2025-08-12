docker run --rm -v "$(pwd):/app" -v "$HOME/.aws:/root/.aws:ro"  -e AWS_REGION="us-east-1" deploy-tools-runner terraform  -chdir=/app/terraform  plan 

docker run --rm -v "$(pwd):/app" -v "$HOME/.aws:/root/.aws:ro"  -e AWS_REGION="us-east-1" deploy-tools-runner terraform  -chdir=/app/terraform  apply -auto-approve

docker run --rm -v "$(pwd):/app" -v "$HOME/.aws:/root/.aws:ro"  -e AWS_REGION="us-east-1" deploy-tools-runner ansible-playbook  /app/ansible/playbooks/upload_s3_content.yml -e "bucket_name=www.aws.vbvntv.org"

