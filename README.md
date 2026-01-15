# CredPal Node.js Application – DevOps Assessment

## Overview

This repository contains a production-ready Node.js application with a complete DevOps implementation, including:

- Containerization with Docker  
- CI/CD pipeline using GitHub Actions  
- Security scanning  
- Infrastructure as Code with Terraform  
- Observability via health and status endpoints  
- Manual approval gating for production releases  

The solution is designed to demonstrate real-world DevOps practices aligned with production standards.


## Application Architecture

### Core Components

- **Backend:** Node.js (Express)
- **Container Runtime:** Docker
- **CI/CD:** GitHub Actions
- **Container Registry:** GitHub Container Registry (GHCR)
- **Database:** PostgreSQL
- **Cloud Target:** AWS (ECS + ALB + RDS)
- **Infrastructure as Code:** Terraform


## Local Development Setup

### Prerequisites

- Docker & Docker Compose
- Node.js 18+
- Git


### Clone Repository

```bash
git clone https://github.com/credpal.git
cd credpal
```

### Run Application with Docker Compose

```bash
docker compose -f docker/docker-compose.yml up --build
```


### The application will be available at:

- http://localhost:3000

- Application Endpoints
- Health Check

```bash
curl http://localhost:3000/health
```

### Expected response:


```bash
{
  "status": "ok"
}
```

Status Endpoint

```bash
curl http://localhost:3000/status
```

Returns application metadata, environment, and timestamp.

## CI/CD Pipeline

The CI/CD pipeline is implemented using GitHub Actions and consists of four main stages.

### 1. Build & Scan Docker Image

- Builds Docker image using Docker Buildx

- Scans the image using Trivy

- Fails only on critical pipeline errors (not vulnerability findings)

### 2. Run Unit Tests

- Installs Node.js dependencies

- Spins up local Docker Compose services

- Waits for application readiness

- Executes unit tests

### 3. Push Image to GitHub Container Registry (GHCR)

- Logs into GitHub Container Registry

- Pushes Docker image using lowercase repository naming

- Triggered only after successful tests

### 4. Manual Approval (Production Gate)

- Executed only via workflow_dispatch

- Prevents accidental production deployments

- Acts as a human-in-the-loop safety control

## Manual Approval Behavior

The manual approval job is intentionally configured to run only when the workflow is manually triggered:


```yaml
if: github.event_name == 'workflow_dispatch'
```

When the pipeline runs on a push to the main branch, this step is skipped by design.

This ensures:

- Continuous Integration runs automatically

- Production deployment requires explicit approval

- Environments are protected from unintended releases

This behavior is expected and intentional.

## Infrastructure as Code (Terraform)

Terraform modules are provided for the following resources:

- VPC

- ECS Cluster & Service

- Application Load Balancer

- RDS PostgreSQL

- IAM Roles and Policies

### Important Note

Terraform apply was not executed due to the absence of cloud credentials during the assessment period.

However:

- All modules are production-ready

- Variables support multiple environments

- Networking and security best practices are followed

- Infrastructure can be deployed immediately when credentials are available

## Security Considerations

- Application runs as a non-root user

- Secrets are injected via environment variables

- No secrets are committed to the repository

- Container images are vulnerability-scanned

- HTTPS termination is assumed at the ALB level using AWS ACM

## Observability

- Health and status endpoints provided for monitoring

- Container logs accessible via Docker or ECS

- Ready for integration with CloudWatch, Prometheus, or ELK stack

## Assumptions & Limitations

- Cloud credentials were unavailable during submission

- Terraform resources were defined but not applied

- SSL certificates assumed to be managed via AWS ACM

- Observability limited to application-level endpoints

These constraints do not affect the architectural validity of the solution.

## Author

Justus Dahunsi
DevSecOps / Platform Engineer