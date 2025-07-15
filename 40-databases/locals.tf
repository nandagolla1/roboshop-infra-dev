locals {
  ami_id = data.aws_ami.joindevops.id
  common_tags = {
    project = var.project
    environment = var.environment
    terraform = true
  }

  mongodb_sg = data.aws_ssm_parameter.mongodb_sg
  database_subnet_ids = split(",", data.aws_ssm_parameter.public_subnet_ids.value)[0] 
}