locals {
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  private_subnets = split(",", data.aws_ssm_parameter.private_subnets.value)
  local_tags = {
  project = var.project
  environment = var.environment
  terraform = true
  }
  backend_sg = data.aws_ssm_parameter.backend_sg.value
}