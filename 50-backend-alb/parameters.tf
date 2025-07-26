resource "aws_ssm_parameter" "backend_alb_listener_arn" {
  name  = "/${var.project}/${var.environment}/${var.backend_alb_sg_name}"
  type  = "String"
  value = aws_lb_listener.backend_alb_listener.arn
  depends_on = [ module.backend_alb ]
}