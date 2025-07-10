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