docker run --rm -v "$(pwd):/app" -v "$HOME/.aws:/root/.aws:ro"  -e AWS_REGION="us-east-1" deploy-tools-runner ansible-playbook /app/ansible/playbooks/delete_s3_content.yml -e "bucket_name=www.aws.vbvntv.org"

docker run --rm -v "$(pwd):/app" -v "$HOME/.aws:/root/.aws:ro"  -e AWS_REGION="us-east-1" deploy-tools-runner terraform -chdir=/app/terraform  destroy -auto-approve