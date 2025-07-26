resource "aws_ssm_parameter" "backend_alb_listener_arn" {
  name  = "/${var.project}/${var.environment}/${var.backend_alb_sg_name}"
  type  = "String"
  value = module.catalogue.sg_id
  depends_on = [ module.backend_alb ]
}