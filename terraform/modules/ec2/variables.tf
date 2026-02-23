variable "env" {}

variable "instance_type" {}

variable "private_subnets" {
  type = list(string)
}

variable "app_sg" {}

variable "target_group_arn" {}

variable "db_host" {}
variable "db_username" {}
variable "db_password" {
  sensitive = true
}

variable "repo_url" {}

variable "min_size" {}
variable "max_size" {}
variable "desired_capacity" {}