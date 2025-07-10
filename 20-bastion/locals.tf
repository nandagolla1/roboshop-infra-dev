locals {
  ami_id = data.aws_ami.joindevops.id
  local_tags = {
    project = var.project
    environment = var.environment
    terraform = true
  }
  bastion_sg_id = data.aws_ssm_parameter.bastion_sg_id.value
  public_subnet_ids = split(",", data.aws_ssm_parameter.public_subnet_ids.value)[0]
}