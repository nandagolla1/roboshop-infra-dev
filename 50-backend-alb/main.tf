module "alb" {
  source = "terraform-aws-modules/alb/aws"
  version = "9.16.0"
  internal = true
  name    = "backend-alb"
  vpc_id  = local.vpc_id
  subnets = local.private_subnets
  create_security_group = false
  security_groups = [local.backend_sg]
  
  tags = merge(
    local.local_tags,
    {
        Name = "${var.project}-${var.environment}-${var.backend_alb_sg_name}"
    }
  )
}