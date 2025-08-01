data "aws_ssm_parameter" "vpc_id" {
  name = "/${var.project}/${var.environment}/vpc_id"
}

data "aws_ssm_parameter" "public_subnets" {
  name = "/${var.project}/${var.environment}/public_subnets"
}

data "aws_ssm_parameter" "frontend_sg" {
  name = "/${var.project}/${var.environment}/${var.frontend_alb_sg_name}-sg-group"
}

data "aws_ssm_parameter" "acm_certificate_arn" {
  name = "/${var.project}/${var.environment}/acm_certificate_arn"
}