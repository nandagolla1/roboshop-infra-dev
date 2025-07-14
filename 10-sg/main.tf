module "frontend" {
  source = "git::https://github.com/nandagolla1/terraform-aws-securitygroup.git?ref=main"
  project = var.project
  environment = var.environment
  sg_name = "${var.project}-${var.environment}-${var.frontend_sg_name}"
  sg_description = var.frontend_sg_description
  vpc_id = local.vpc_id
}

module "bastion" {
  source = "git::https://github.com/nandagolla1/terraform-aws-securitygroup.git?ref=main"
  project = var.project
  environment = var.environment
  sg_name = "${var.project}-${var.environment}-${var.bastion_sg_name}"
  sg_description = var.bastion_sg_description
  vpc_id = local.vpc_id
}

module "backend_alb" {
  source = "git::https://github.com/nandagolla1/terraform-aws-securitygroup.git?ref=main"
  project = var.project
  environment = var.environment
  sg_name = "${var.project}-${var.environment}-${var.backend_alb_sg_name}"
  sg_description = var.backend_alb_sg_description
  vpc_id = local.vpc_id
}

# attach rules to the bastion to allow access to the bastion server
resource "aws_security_group_rule" "bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.bastion.sg_id
}

# attach rules to the backend alb to allow access from the bastion server
resource "aws_security_group_rule" "backend_alb" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id = module.bastion.sg_id
}

