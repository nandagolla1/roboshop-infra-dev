locals {
  openvpn_ami = data.aws_ami.openvpn.id
  vpn_sg = data.aws_ssm_parameter.vpn_sg.value
  public_subnet_ids = split(",", data.aws_ssm_parameter.public_subnet_ids.value)[0]

  local_tags = {
    project = var.project
    environment = var.environment
    terraform = true
  }
}