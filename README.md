# CredPal DevOps Engineer Assessment – Node.js Application

---

## Project Overview

This project demonstrates a **production-ready DevOps pipeline and infrastructure** setup for a simple Node.js application. The application is designed to run in a **cloud environment** and showcases containerization, CI/CD, and infrastructure as code best practices.

The application exposes the following endpoints on port `3000`:

- `GET /health` – Checks the health of the application.
- `GET /status` – Returns application metadata, environment, and timestamp.
- `POST /process` – Accepts JSON payloads and processes requests.

---

## Folder Structure

\`\`\`
credpal/
│
├── app/
│   ├── src/
│   │   ├── routes/
│   │   │   ├── health.js
│   │   │   ├── status.js
│   │   │   └── process.js
│   │   ├── app.js
│   │   └── server.js
│   ├── tests/
│   │   └── health.test.js
│   ├── package.json
│   ├── package-lock.json
│   └── .env.example
│
├── docker/
│   ├── Dockerfile
│   └── docker-compose.yml
│
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── providers.tf
│   ├── terraform.tfvars.example
│   └── modules/
│       ├── vpc/
│       ├── ecs/
│       ├── alb/
│       └── rds/
│
├── .github/
│   └── workflows/
│       └── ci-cd.yml
├── .gitignore
├── README.md
└── Makefile
\`\`\`

---

## How to Run the Application Locally

1. **Set up environment variables**

\`\`\`bash
cp app/.env.example app/.env
\`\`\`

2. **Build and run containers using Docker Compose**

\`\`\`bash
docker compose -f docker/docker-compose.yml up --build
\`\`\`

This will:

- Build the Node.js application container (multi-stage, production-ready, non-root user)
- Launch a PostgreSQL database container
- Connect the application to the database via environment variables

3. **Test endpoints locally**

\`\`\`bash
curl http://localhost:3000/health
curl http://localhost:3000/status
curl -X POST http://localhost:3000/process -H "Content-Type: application/json" -d '{"test":"ok"}'
\`\`\`

---

## How to Access the Application

- **Locally:** `http://localhost:3000`
- **Containerized Environment:** Managed by Docker Compose; ports are mapped from container to host (`3000:3000`).
- **Cloud Deployment:** Intended to be deployed on AWS ECS behind an Application Load Balancer (ALB) with HTTPS enabled.

---

## How to Deploy the Application

### CI/CD Pipeline (GitHub Actions)

The pipeline performs the following steps automatically on:

- **Push to main**  
- **Pull requests to main**

**Pipeline Steps:**

1. **Checkout code** – Uses the latest commit from GitHub.
2. **Install dependencies** – `npm ci` ensures reproducible builds.
3. **Run tests** – Optional unit tests verify the application functionality.
4. **Build Docker image** – Uses multi-stage Dockerfile for production-ready images.
5. **Push to GitHub Container Registry** – Centralized and secure image storage.
6. **Manual approval for production** – Ensures safety before deploying to live environment.

---

### Infrastructure as Code (Terraform)

Modules are defined for:

- **VPC** – Isolated networking with subnets and security groups.
- **ECS** – Runs containerized Node.js application; scalable and managed.
- **ALB (Application Load Balancer)** – Routes traffic, enables HTTPS, and supports rolling or blue-green deployments.
- **RDS (PostgreSQL)** – Managed database with backups and replication.

Terraform **variables** allow environment customization (dev/staging/prod). Outputs provide useful references for other modules or deployment scripts.

> **Note:** Terraform `apply` was not executed due to lack of cloud access. All infrastructure is fully defined and ready to deploy.

---

## Key Decisions and Rationale

### Security

- **Non-root user in Dockerfile** – Prevents privilege escalation inside the container.
- **Environment variables for secrets** – No secrets are committed to GitHub.
- **SSL via ALB** – Encrypts traffic between clients and application.
- **Minimal Docker image** – Reduces attack surface.

### CI/CD Decisions

- **GitHub Actions** – Provides automated, reproducible pipelines.
- **Manual approval** – Ensures zero-downtime and safe deployment.
- **Vulnerability scans** – Trivy or SonarQube can be added to detect insecure dependencies.

### Infrastructure Decisions

- **Terraform Modules** – Enables reusable, maintainable, and scalable infrastructure.
- **ECS vs EC2** – ECS chosen for ease of container orchestration and integration with AWS services.
- **ALB** – Ensures traffic distribution, rolling deployments, and HTTPS termination.
- **RDS** – Managed database for high availability and backups.
- **VPC and Security Groups** – Network isolation and controlled access.

---

## Observability

- **Health endpoints** – `/health` and `/status` enable monitoring.
- **Basic logging** – `console.log()` statements for application activity tracking.
- **Pipeline monitoring** – CI/CD provides logs of build, test, and deployment steps.

---

## Author

**Justus Dahunsi** – CredPal DevOps Assessment

---

This README demonstrates the setup of a **robust, secure, production-ready DevOps pipeline** for a Node.js application, including **local development, containerization, CI/CD, and infrastructure as code**.
