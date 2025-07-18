module "backend_alb" {
  source = "terraform-aws-modules/alb/aws"
  version = "9.16.0"
  internal = true
  name    = "backend-alb"
  vpc_id  = local.vpc_id
  subnets = local.private_subnets
  create_security_group = false
  security_groups = [local.backend_sg]

  enable_deletion_protection = false
  
  tags = merge(
    local.local_tags,
    {
        Name = "${var.project}-${var.environment}-${var.backend_alb_sg_name}"
    }
  )
}

resource "aws_lb_listener" "backend_alb_listener" {
  load_balancer_arn = module.backend_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/html"
      message_body = "<h1>Hi I'm from from backend alb</h1>"
      status_code  = "200"
    }
  }
}


resource "aws_route53_record" "backend_alb" {
  zone_id = var.zone_id
  name    = "*.backend-dev.${var.domain_name}"
  type    = "A"

  alias {
    name                   = module.backend_alb.dns_name
    zone_id                = module.backend_alb.zone_id
    evaluate_target_health = true
  }
  allow_overwrite = true
}