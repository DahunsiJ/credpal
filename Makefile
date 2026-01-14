# Docker commands
build:
	docker compose -f docker/docker-compose.yml build

up:
	docker compose -f docker/docker-compose.yml up

down:
	docker compose -f docker/docker-compose.yml down

# Terraform commands
tf-init:
	cd terraform && terraform init

tf-plan:
	cd terraform && terraform plan -var-file=terraform.tfvars.example

tf-apply:
	cd terraform && terraform apply -var-file=terraform.tfvars.example
