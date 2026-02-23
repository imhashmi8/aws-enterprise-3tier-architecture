# AWS Enterprise 3-Tier Architecture  
### Terraform | Docker | Auto Scaling | Multi-AZ | Dev/Prod Environments  

Designed & Engineered by **Md Qamar Hashmi**  
DevOps | SRE | Cloud Engineer  

---

## Project Overview

This project demonstrates a **production-grade 3-tier architecture on AWS** using:

- Modular Terraform
- Environment separation (dev & prod)
- Dockerized application deployment
- Auto Scaling Group
- Application Load Balancer
- Multi-AZ RDS (Production)
- Secure VPC networking

The goal is to simulate a **real-world enterprise infrastructure setup** following best practices in scalability, high availability, and security.

---

## Architecture Diagram

![AWS 3-Tier Architecture](./assets/architecture.png)


---

## Architecture Components

### Web Tier
- Application Load Balancer (ALB)
- Public Subnets (Multi-AZ)

### Application Tier
- EC2 Instances (Private Subnets)
- Docker-based Flask App
- Auto Scaling Group
- Launch Templates
- User Data provisioning

### Database Tier
- Amazon RDS (MySQL)
- Multi-AZ in Production
- DB Subnet Group
- Private Access Only

---

## Security Design

- Private EC2 instances (no public IPs)
- Security group isolation per tier
- ALB exposed publicly (HTTP)
- RDS accessible only from application tier
- Environment-based tagging

---

## Repository Structure

```
terraform/
│
├── modules/
│   ├── vpc/
│   ├── security/
│   ├── rds/
│   ├── alb/
│   └── ec2/
│
├── environments/
│   ├── dev/
│   │   ├── backend.tf
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── terraform.tfvars
│   │
│   └── prod/
│       ├── backend.tf
│       ├── main.tf
│       ├── variables.tf
│       └── terraform.tfvars
│
└── versions.tf
```

---

## Dev vs Prod Differences

| Feature | Dev | Prod |
|----------|------|------|
| RDS | Single-AZ | Multi-AZ |
| ASG Capacity | 1–2 instances | 2–4 instances |
| CIDR Range | 10.1.0.0/16 | 10.0.0.0/16 |
| Cost Optimized | Yes | High Availability |

---

## Application Layer

- Flask-based web app
- Dockerized
- Gunicorn production server
- Health endpoint `/health`
- Database connectivity to RDS
- Styled frontend UI

---

## Deployment Instructions

### Deploy Dev

```bash
cd terraform/environments/dev
terraform init
terraform plan
terraform apply
```

### Deploy Prod

```bash
cd terraform/environments/prod
terraform init
terraform plan
terraform apply
```

After successful deployment:

```
alb_dns = xxxx.ap-south-1.elb.amazonaws.com
```

Open the ALB DNS in your browser.

## Live Application Screenshot

![App Screenshot](./assets/app.png)

---

## Key DevOps Concepts Demonstrated

- Infrastructure as Code (Terraform)
- Modular Terraform design
- Dev/Prod environment separation
- Multi-AZ architecture
- Auto Scaling Groups
- Launch Templates
- User Data automation
- Docker-based deployment
- Secure VPC isolation
- Health checks & ALB integration

---

## 💰 Cost Consideration

Resources created:
- EC2 instances
- RDS instance
- NAT Gateway
- ALB

To avoid charges:

```bash
terraform destroy
```

---

## Resume Highlight

> Designed and deployed a production-grade 3-tier AWS architecture using modular Terraform with Multi-AZ RDS, Auto Scaling, private networking, Dockerized application deployment, and environment separation (dev/prod).

---

## Author

**Md Qamar Hashmi**  
Cloud & DevOps Engineer  
AWS | Kubernetes | Terraform | CI/CD | MLOps  

---
