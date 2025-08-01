resource "aws_ssm_parameter" "mongodb" {
  name  = "/${var.project}/${var.environment}/${var.mongodb_sg_name}-sg-group"
  type  = "String"
  value = module.mongodb.sg_id
  depends_on = [ module.mongodb ]
}

resource "aws_ssm_parameter" "redis" {
  name  = "/${var.project}/${var.environment}/${var.redis_sg_name}-sg-group"
  type  = "String"
  value = module.redis.sg_id
  depends_on = [ module.redis ]
}

resource "aws_ssm_parameter" "mysql" {
  name  = "/${var.project}/${var.environment}/${var.mysql_sg_name}-sg-group"
  type  = "String"
  value = module.mysql.sg_id
  depends_on = [ module.mysql ]
}

resource "aws_ssm_parameter" "rabbitmq" {
  name  = "/${var.project}/${var.environment}/${var.rabbitmq_sg_name}-sg-group"
  type  = "String"
  value = module.rabbitmq.sg_id
  depends_on = [ module.rabbitmq ]
}

resource "aws_ssm_parameter" "catalogue" {
  name  = "/${var.project}/${var.environment}/${var.catalogue_sg_name}-sg-group"
  type  = "String"
  value = module.catalogue.sg_id
  depends_on = [ module.catalogue ]
}

resource "aws_ssm_parameter" "user" {
  name  = "/${var.project}/${var.environment}/${var.user_sg_name}-sg-group"
  type  = "String"
  value = module.user.sg_id
  depends_on = [ module.user ]
}

resource "aws_ssm_parameter" "cart" {
  name  = "/${var.project}/${var.environment}/${var.cart_sg_name}-sg-group"
  type  = "String"
  value = module.cart.sg_id
  depends_on = [ module.cart ]
}

resource "aws_ssm_parameter" "shipping" {
  name  = "/${var.project}/${var.environment}/${var.shipping_sg_name}-sg-group"
  type  = "String"
  value = module.shipping.sg_id
  depends_on = [ module.shipping ]
}

resource "aws_ssm_parameter" "payment" {
  name  = "/${var.project}/${var.environment}/${var.payment_sg_name}-sg-group"
  type  = "String"
  value = module.payment.sg_id
  depends_on = [ module.payment ]
}

resource "aws_ssm_parameter" "backend_alb" {
  name  = "/${var.project}/${var.environment}/${var.backend_alb_sg_name}-sg-group"
  type  = "String"
  value = module.backend_alb.sg_id
  depends_on = [ module.backend_alb ]
}

resource "aws_ssm_parameter" "frontend" {
  name  = "/${var.project}/${var.environment}/${var.frontend_sg_name}-sg-group"
  type  = "String"
  value = module.frontend.sg_id
  depends_on = [ module.frontend ]
}

resource "aws_ssm_parameter" "frontend_alb" {
  name  = "/${var.project}/${var.environment}/${var.frontend_alb_sg_name}-sg-group"
  type  = "String"
  value = module.frontend_alb.sg_id
  depends_on = [ module.frontend_alb ]
}

resource "aws_ssm_parameter" "bastion" {
  name  = "/${var.project}/${var.environment}/${var.bastion_sg_name}-sg-group"
  type  = "String"
  value = module.bastion.sg_id
  depends_on = [ module.bastion ]
}

resource "aws_ssm_parameter" "vpn" {
  name  = "/${var.project}/${var.environment}/${var.vpn_sg_name}-sg-group"
  type  = "String"
  value = module.vpn.sg_id
  depends_on = [ module.vpn ]
}