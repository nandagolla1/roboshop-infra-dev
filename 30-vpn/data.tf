data "aws_ami" "openvpn" {
  most_recent = true
  owners = [ "679593333241" ]

  filter {
    name   = "name"
    values = ["OpenVPN Access Server Community Image-8fbe3379-63b6-43e8-87bd-0e93fd7be8f3"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}


data "aws_ssm_parameter" "vpn_sg" {
  name = "/${var.project}/${var.environment}/vpn-sg-group"
}

data "aws_ssm_parameter" "public_subnet_ids" {
  name  = "/${var.project}/${var.environment}/public_subnets"
}