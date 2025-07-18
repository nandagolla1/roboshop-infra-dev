locals {
  ami_id = data.aws_ami.joindevops.id
  common_tags = {
    project = var.project
    environment = var.environment
    terraform = true
  }
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  catalogue_sg = data.aws_ssm_parameter.catalogue_sg_id.value
  private_subnets_ids = split(",", data.aws_ssm_parameter.private_subnets.value)[0]
}