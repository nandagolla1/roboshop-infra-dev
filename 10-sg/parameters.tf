resource "aws_ssm_parameter" "main" {
  name  = "/${var.project}/${var.environment}/${var.frontend_sg_name}-sg-group"
  type  = "String"
  value = module.frontend.sg_id
  depends_on = [ module.frontend ]
}