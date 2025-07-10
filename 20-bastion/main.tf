resource "aws_instance" "bastion_sever" {
  ami           = local.ami_id
  instance_type = "t3.micro"
  vpc_security_group_ids = [local.bastion_sg_id]
  subnet_id = local.public_subnet_ids

  tags = merge(
    local.local_tags,
    {
        Name = "${var.project}-${var.environment}-bastion"
    }
  )
}