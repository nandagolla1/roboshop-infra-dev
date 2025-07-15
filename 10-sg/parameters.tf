resource "aws_ssm_parameter" "frontend" {
  name  = "/${var.project}/${var.environment}/${var.frontend_sg_name}-sg-group"
  type  = "String"
  value = module.frontend.sg_id
  depends_on = [ module.frontend ]
}

resource "aws_ssm_parameter" "bastion" {
  name  = "/${var.project}/${var.environment}/${var.bastion_sg_name}-sg-group"
  type  = "String"
  value = module.bastion.sg_id
  depends_on = [ module.bastion ]
}

resource "aws_ssm_parameter" "backend_alb" {
  name  = "/${var.project}/${var.environment}/${var.backend_alb_sg_name}-sg-group"
  type  = "String"
  value = module.backend_alb.sg_id
  depends_on = [ module.backend_alb ]
}

resource "aws_ssm_parameter" "vpn" {
  name  = "/${var.project}/${var.environment}/${var.vpn_sg_name}-sg-group"
  type  = "String"
  value = module.vpn.sg_id
  depends_on = [ module.vpn ]
}

resource "aws_ssm_parameter" "mongodb" {
  name  = "/${var.project}/${var.environment}/${var.mongodb_sg_name}-sg-group"
  type  = "String"
  value = module.vpn.sg_id
  depends_on = [ module.mongodb ]
}