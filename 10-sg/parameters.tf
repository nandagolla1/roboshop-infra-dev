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
  value = module.bastion.sg_id
  depends_on = [ module.backend_alb ]
}