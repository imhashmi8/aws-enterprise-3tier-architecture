resource "aws_db_subnet_group" "this" {
  subnet_ids = var.db_subnets
}

resource "aws_db_instance" "this" {
  engine               = "mysql"
  instance_class       = var.instance_class
  allocated_storage    = 20
  username             = var.db_username
  password             = var.db_password
  multi_az             = var.multi_az
  skip_final_snapshot  = true
  vpc_security_group_ids = [var.db_sg]
  db_subnet_group_name = aws_db_subnet_group.this.name
}