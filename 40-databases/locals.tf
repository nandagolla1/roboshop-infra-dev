locals {
  ami_id = data.aws_ami.joindevops.id
  common_tags = {
    project = var.project
    environment = var.environment
    terraform = true
  }

  mongodb_sg = data.aws_ssm_parameter.mongodb_sg.value
  database_subnet_ids = split(",", data.aws_ssm_parameter.database_subnets.value)[0] 
  redis_sg = data.aws_ssm_parameter.redis_sg.value
  mysql_sg = data.aws_ssm_parameter.mysql_sg.value
  rabbitmq_sg = data.aws_ssm_parameter.rabbitmq_sg.value
}