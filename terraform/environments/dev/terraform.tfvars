region = "ap-south-1"

vpc_cidr = "10.1.0.0/16"

public_subnets  = ["10.1.1.0/24", "10.1.2.0/24"]
private_subnets = ["10.1.3.0/24", "10.1.4.0/24"]
db_subnets      = ["10.1.5.0/24", "10.1.6.0/24"]

instance_type = "t3.micro"

db_username = "admin"
db_password = "DevPassword123!"

repo_url = "https://github.com/imhashmi8/aws-enterprise-3tier-architecture"