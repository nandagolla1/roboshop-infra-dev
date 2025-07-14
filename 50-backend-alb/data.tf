data "aws_ssm_parameter" "vpc_id" {
  name = "/${var.project}/${var.environment}/vpc_id"
}

data "aws_ssm_parameter" "vpc_id" {
  name = "/${var.project}/${var.environment}/vpc_id"
}

data "aws_ssm_parameter" "private_subnets" {
  name = "/${var.project}/${var.environment}/private_subnets"
}

data "aws_ssm_parameter" "backend_sg" {
  name = "/${var.project}/${var.environment}/${var.backend_alb_sg_name}-sg-group"
}