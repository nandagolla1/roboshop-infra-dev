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