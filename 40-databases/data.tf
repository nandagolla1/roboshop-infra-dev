data "aws_ami" "joindevops" {
  most_recent = true
  owners = [ "973714476881" ]

  filter {
    name   = "name"
    values = ["RHEL-9-DevOps-Practice"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}


data "aws_ssm_parameter" "mongodb_sg" {
  name = "/${var.project}/${var.environment}/${var.mongodb_sg_name}-sg-group"
}

data "aws_ssm_parameter" "database_subnets" {
  name  = "/${var.project}/${var.environment}/database_subnets"
}

data "aws_ssm_parameter" "redis_sg" {
  name = "/${var.project}/${var.environment}/${var.redis_sg_name}-sg-group"
}

data "aws_ssm_parameter" "mysql_sg" {
  name = "/${var.project}/${var.environment}/${var.mysql_sg_name}-sg-group"
}

data "aws_ssm_parameter" "rabbitmq_sg" {
  name = "/${var.project}/${var.environment}/${var.rabbitmq_sg_name}-sg-group"
}