
# CredPal Node.js Application – Operational Runbook

## Purpose

This runbook provides operational guidance for running, monitoring, and troubleshooting the CredPal Node.js application in both local and production environments.

It is intended for DevOps engineers, SREs, and on-call responders.



## Service Overview

| Item | Value |
|----|----|
| Service Name | CredPal Node.js API |
| Runtime | Node.js 18 |
| Container Platform | Docker / AWS ECS |
| Listening Port | 3000 |
| Database | PostgreSQL |
| Registry | GitHub Container Registry |



## Starting the Service Locally

### Using Docker Compose

```bash
docker compose -f docker/docker-compose.yml up --build
```

Expected outcome:

- Application container starts successfully

- PostgreSQL container is healthy

- Application reachable on port 3000


## Health & Readiness Checks

### Health Endpoint

```bash
curl http://localhost:3000/health
```

Expected response:

```json
{
  "status": "ok"
}
```

### Status Endpoint

```bash
curl http://localhost:3000/status
```
Provides runtime metadata useful for debugging.

## CI/CD Pipeline Reference
Pipeline Stages

- Docker image build

- Vulnerability scanning

- Unit testing

- Image push to registry

- Manual approval (production)

Production deployments are gated behind manual approval to reduce risk.


## Common Operational Tasks
### View Application Logs

```bash
docker compose logs app
```

### Restart Application

```bash
docker compose restart app
```

### Tear Down Environment

```bash
docker compose down
```

## Troubleshooting Guide
### Application Fails to Start
Checks:

- Inspect logs

- Verify port 3000 availability

- Confirm environment variables

```bash
docker compose logs app
```

### Database Connection Errors
Possible Causes:

- PostgreSQL container not running

- Incorrect connection string

- Network misconfiguration

#### Resolution:

```bash
docker compose ps
docker compose logs db
```

## CI Pipeline Fails During Image Push
#### Likely Cause:
- Likely Cause:
#### Resolution:
- Ensure repository owner and image name are lowercase

## Security Practices
- Containers run as non-root

- Secrets injected at runtime

- No credentials stored in GitHub

- Registry access controlled via GitHub token


## Incident Response (High Level)
- Check health endpoint

- Review container logs

- Restart service if necessary

- Roll back to last known good image

- Escalate if database or infrastructure is affected


## Ownership & Escalation
- Service Owner: Platform / DevOps Team

- Maintainer: Justus Dahunsi


## Change Management
All changes must pass CI checks and require manual approval before production deployment.

This ensures traceability, stability, and auditability.

