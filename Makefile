APP_NAME=credpal
IMAGE_NAME=$(APP_NAME):latest
REGISTRY_IMAGE=ghcr.io/DahunsiJ/$(APP_NAME):latest

.PHONY: help install test build scan compose-up compose-down ci-build ci-test ci-push deploy-prod

help:
	@echo "Available commands:"
	@echo "  make install        Install dependencies"
	@echo "  make test           Run unit tests"
	@echo "  make build          Build Docker image locally"
	@echo "  make scan           Scan Docker image with Trivy"
	@echo "  make compose-up     Start application using Docker Compose"
	@echo "  make compose-down   Stop Docker Compose services"
	@echo "  make ci-build       CI-equivalent build + scan"
	@echo "  make ci-test        CI-equivalent test run"
	@echo "  make ci-push        CI-equivalent image push (after tests)"
	@echo "  make deploy-prod    Production deployment (manual approval required)"

install:
	cd app && npm ci

test:
	cd app && npm test

build:
	docker build -f docker/Dockerfile -t $(IMAGE_NAME) .

scan:
	trivy image $(IMAGE_NAME)

compose-up:
	docker compose -f docker/docker-compose.yml up -d --build

compose-down:
	docker compose -f docker/docker-compose.yml down

# ----------------------------
# CI-Equivalent Targets
# ----------------------------

ci-build: build scan
	@echo "✅ Build and scan completed"

ci-test: install test
	@echo "✅ Tests completed"

ci-push: ci-test
	@echo "ℹ️ Image push is handled by GitHub Actions after CI passes"
	@echo "ℹ️ Manual approval is required before production deployment"

# ----------------------------
# Production Gate
# ----------------------------

deploy-prod:
	@echo "🚫 Production deployments are gated"
	@echo "➡️ Trigger deployment via GitHub Actions (workflow_dispatch)"
	@echo "➡️ Manual approval is required before production release"
