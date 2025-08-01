resource "aws_ssm_parameter" "frontend_alb_listener_arn" {
  name  = "/${var.project}/${var.environment}/${var.frontend_alb_sg_name}"
  type  = "String"
  value = aws_lb_listener.frontend_alb_listener.arn
  depends_on = [ module.frontend_alb ]
}