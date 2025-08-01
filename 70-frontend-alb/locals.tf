locals {
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  public_subnets = split(",", data.aws_ssm_parameter.public_subnets.value)
  local_tags = {
  project = var.project
  environment = var.environment
  terraform = true
  }
  frontend_sg = data.aws_ssm_parameter.frontend_sg.value
  acm_certificate_arn = data.aws_ssm_parameter.acm_certificate_arn.value
}