variable "region" {}
variable "vpc_cidr" {}

variable "public_subnets" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

variable "db_subnets" {
  type = list(string)
}

variable "instance_type" {}

variable "db_username" {}
variable "db_password" {
  sensitive = true
}

variable "repo_url" {}