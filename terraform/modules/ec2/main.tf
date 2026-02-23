data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
}

resource "aws_launch_template" "this" {
  name_prefix   = "${var.env}-lt-"
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type

  network_interfaces {
    associate_public_ip_address = false
    security_groups             = [var.app_sg]
  }

  user_data = base64encode(<<EOF
#!/bin/bash
yum update -y
yum install -y docker git
systemctl start docker
usermod -aG docker ec2-user

cd /home/ec2-user
git clone ${var.repo_url}
cd AWS-ENTERPRISE-3TIER-ARCHITECTURE

docker build -t 3tier-app .
docker run -d -p 80:80 \
-e DB_HOST=${var.db_host} \
-e DB_USER=${var.db_username} \
-e DB_PASSWORD=${var.db_password} \
-e DB_NAME=appdb \
3tier-app
EOF
  )

  tag_specifications {
    resource_type = "instance"

    tags = {
      Environment = var.env
    }
  }
}

resource "aws_autoscaling_group" "this" {
  name               = "${var.env}-asg"
  min_size           = var.min_size
  max_size           = var.max_size
  desired_capacity   = var.desired_capacity
  vpc_zone_identifier = var.private_subnets

  launch_template {
    id      = aws_launch_template.this.id
    version = "$Latest"
  }

  target_group_arns = [var.target_group_arn]

  health_check_type = "ELB"

  tag {
    key                 = "Environment"
    value               = var.env
    propagate_at_launch = true
  }
}