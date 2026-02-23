provider "aws" {
  region = var.region
}

############################
# VPC
############################

module "vpc" {
  source = "../../modules/vpc"

  env              = "prod"
  vpc_cidr         = var.vpc_cidr
  public_subnets   = var.public_subnets
  private_subnets  = var.private_subnets
  db_subnets       = var.db_subnets
}

############################
# Security Groups
############################

module "security" {
  source = "../../modules/security"

  vpc_id = module.vpc.vpc_id
}

############################
# RDS (Multi-AZ for PROD)
############################

module "rds" {
  source = "../../modules/rds"

  db_subnets     = module.vpc.db_subnets
  db_sg          = module.security.db_sg
  db_username    = var.db_username
  db_password    = var.db_password

  instance_class = "db.t3.micro"
  multi_az       = true
}

############################
# ALB
############################

module "alb" {
  source = "../../modules/alb"

  env             = "prod"
  vpc_id          = module.vpc.vpc_id
  public_subnets  = module.vpc.public_subnets
  alb_sg          = module.security.alb_sg
}

############################
# EC2 + ASG
############################

module "ec2" {
  source = "../../modules/ec2"

  env              = "prod"
  instance_type    = var.instance_type
  private_subnets  = module.vpc.private_subnets
  app_sg           = module.security.app_sg
  target_group_arn = module.alb.target_group_arn

  db_host     = module.rds.db_endpoint
  db_username = var.db_username
  db_password = var.db_password

  repo_url = var.repo_url

  min_size         = 2
  max_size         = 4
  desired_capacity = 2
}

############################
# Outputs
############################

output "alb_dns" {
  value = module.alb.alb_dns
}