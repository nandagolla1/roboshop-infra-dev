module "frontend" {
  source = "git::https://github.com/nandagolla1/terraform-aws-securitygroup.git?ref=main"
  project = var.project
  environment = var.environment
  sg_name = var.frontend_sg_name
  sg_description = var.sg_description
  vpc_id = data.aws_ssm_parameter.vpc_id.value
}