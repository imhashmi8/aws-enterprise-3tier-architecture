variable "db_subnets" {}
variable "db_sg" {}
variable "db_username" {}
variable "db_password" { sensitive = true }
variable "instance_class" {}
variable "multi_az" {}