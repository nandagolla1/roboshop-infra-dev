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

module "vpn" {
  source = "git::https://github.com/nandagolla1/terraform-aws-securitygroup.git?ref=main"
  project = var.project
  environment = var.environment
  sg_name = "${var.project}-${var.environment}-${var.vpn_sg_name}"
  sg_description = var.vpn_sg_description
  vpc_id = local.vpc_id
}

module "mongodb" {
  source = "git::https://github.com/nandagolla1/terraform-aws-securitygroup.git?ref=main"
  project = var.project
  environment = var.environment
  sg_name = "${var.project}-${var.environment}-${var.mongodb_sg_name}"
  sg_description = var.mongodb_sg_description
  vpc_id = local.vpc_id
}

module "redis" {
  source = "git::https://github.com/nandagolla1/terraform-aws-securitygroup.git?ref=main"
  project = var.project
  environment = var.environment
  sg_name = "${var.project}-${var.environment}-${var.redis_sg_name}"
  sg_description = var.redis_sg_description
  vpc_id = local.vpc_id
}

module "mysql" {
  source = "git::https://github.com/nandagolla1/terraform-aws-securitygroup.git?ref=main"
  project = var.project
  environment = var.environment
  sg_name = "${var.project}-${var.environment}-${var.mysql_sg_name}"
  sg_description = var.mysql_sg_description
  vpc_id = local.vpc_id
}

module "rabbitmq" {
  source = "git::https://github.com/nandagolla1/terraform-aws-securitygroup.git?ref=main"
  project = var.project
  environment = var.environment
  sg_name = "${var.project}-${var.environment}-${var.rabbitmq_sg_name}"
  sg_description = var.rabbitmq_sg_description
  vpc_id = local.vpc_id
}

module "catalogue" {
  source = "git::https://github.com/nandagolla1/terraform-aws-securitygroup.git?ref=main"
  project = var.project
  environment = var.environment
  sg_name = "${var.project}-${var.environment}-${var.catalogue_sg_name}"
  sg_description = var.catalogue_sg_description
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
  security_group_id = module.backend_alb.sg_id
}

# attach rules to the vpn server to allow access from internet
# vpn ports 22, 443, 1194, 943
resource "aws_security_group_rule" "vpn_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.vpn.sg_id
}

resource "aws_security_group_rule" "vpn_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.vpn.sg_id
}

resource "aws_security_group_rule" "vpn_1194" {
  type              = "ingress"
  from_port         = 1194
  to_port           = 1194
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.vpn.sg_id
}
resource "aws_security_group_rule" "vpn_943" {
  type              = "ingress"
  from_port         = 943
  to_port           = 943
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.vpn.sg_id
}

# attach rules to the backend alb to allow access from the vpn server
resource "aws_security_group_rule" "backend_alb_vpn" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.backend_alb.sg_id
}

# attach rules to the backend alb to allow access from the vpn server
resource "aws_security_group_rule" "mongodb" {
  count = length(var.mongodb_ports)
  type              = "ingress"
  from_port         = var.mongodb_ports[count.index]
  to_port           = var.mongodb_ports[count.index]
  protocol          = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.mongodb.sg_id
}

resource "aws_security_group_rule" "redis" {
  count = length(var.redis_ports)
  type              = "ingress"
  from_port         = var.redis_ports[count.index]
  to_port           = var.redis_ports[count.index]
  protocol          = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.redis.sg_id
}

resource "aws_security_group_rule" "mysql" {
  count = length(var.mysql_ports)
  type              = "ingress"
  from_port         = var.mysql_ports[count.index]
  to_port           = var.mysql_ports[count.index]
  protocol          = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.mysql.sg_id
}

resource "aws_security_group_rule" "rabbitmq" {
  count = length(var.rabbitmq_ports)
  type              = "ingress"
  from_port         = var.rabbitmq_ports[count.index]
  to_port           = var.rabbitmq_ports[count.index]
  protocol          = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.rabbitmq.sg_id
}

resource "aws_security_group_rule" "mongodb_catalogue" {
  type              = "ingress"
  from_port         = 27017
  to_port           = 27017
  protocol          = "tcp"
  source_security_group_id = module.catalogue.sg_id
  security_group_id = module.mongodb.sg_id
}

resource "aws_security_group_rule" "catalogue_vpn_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.catalogue.sg_id
}

resource "aws_security_group_rule" "catalogue_bastion_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id = module.catalogue.sg_id
}

resource "aws_security_group_rule" "catalogue_vpn_http" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.catalogue.sg_id
}

resource "aws_security_group_rule" "catalogue_backend_alb" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.backend_alb.sg_id
  security_group_id = module.catalogue.sg_id
}