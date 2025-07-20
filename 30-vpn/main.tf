resource "aws_instance" "vpn" {
  ami           = local.openvpn_ami
  instance_type = "t3.micro"
  vpc_security_group_ids = [local.vpn_sg]
  subnet_id = local.public_subnet_ids
  key_name = "Devops_keypair"

  user_data = file("openvpn.sh")
  
  tags = merge(
    local.local_tags,
    {
        Name = "${var.project}-${var.environment}-vpn"
    }
  )
}

resource "aws_route53_record" "vpn" {
  zone_id = var.zone_id
  name    = "vpn-dev.${var.domain_name}"
  type    = "A"
  ttl     = 1
  records = [aws_instance.vpn.public_ip]
  allow_overwrite = true
}