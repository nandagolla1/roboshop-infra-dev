resource "aws_ssm_parameter" "vpc_id" {
  name  = "/${var.project}/${var.environment}/vpc_id"
  type  = "String"
  value = module.vpc.vpc_id
  depends_on = [ module.vpc ]
}

resource "aws_ssm_parameter" "public_subnets" {
  name  = "/${var.project}/${var.environment}/public_subnets"
  type  = "StringList"
  value = join(",", module.vpc.public_subnet_list)
  depends_on = [ module.vpc ]
}

resource "aws_ssm_parameter" "private_subnets" {
  name  = "/${var.project}/${var.environment}/private_subnets"
  type  = "StringList"
  value = join(",", module.vpc.public_subnet_list)
  depends_on = [ module.vpc ]
}

resource "aws_ssm_parameter" "database_subnets" {
  name  = "/${var.project}/${var.environment}/database_subnets"
  type  = "StringList"
  value = join(",", module.vpc.public_subnet_list)
  depends_on = [ module.vpc ]
}
