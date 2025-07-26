resource "aws_lb_target_group" "catalogue" {
  name        = "${var.project}-${var.environment}-catalogue"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = local.vpc_id
  deregistration_delay = 120

  health_check {
    healthy_threshold = 2
    interval = 5
    matcher = "200-299"
    path = "/health"
    port =8080
    protocol = "HTTP"
    timeout = 2
    unhealthy_threshold = 3
  }
}

# catalogue instance


resource "aws_instance" "catalogue" {
  ami           = local.ami_id
  instance_type = "t3.micro"
  vpc_security_group_ids = [local.catalogue_sg]
  subnet_id = local.private_subnets_ids

  tags = merge(
    local.common_tags,
    {
        Name = "${var.project}-${var.environment}-${var.catalogue_sg_name}"
    }
  )
}

resource "terraform_data" "catalogue" {
  triggers_replace = [
    aws_instance.catalogue.id
  ]

  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.catalogue.private_ip
    }

  provisioner "file" {
    source      = "catalogue.sh"
    destination = "/tmp/catalogue.sh"
  }

  provisioner "remote-exec" {
    inline = [ 
        "chmod +x /tmp/catalogue.sh",
        "sudo sh /tmp/catalogue.sh catalogue ${var.environment}"
     ]
  }
}

# stop the instance
resource "aws_ec2_instance_state" "catalogue" {
  instance_id = aws_instance.catalogue.id
  state       = "stopped"
  depends_on = [ terraform_data.catalogue ]
}

# take ami from the configured instance
resource "aws_ami_from_instance" "catalogue" {
  name               = "${var.project}-${var.environment}-catalogue"
  source_instance_id = aws_instance.catalogue.id
  depends_on = [ aws_ec2_instance_state.catalogue ]
  tags = merge(
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}-catalogue"
    }
  )
}

# destroy the instance
resource "terraform_data" "delete_catalogue" {
  triggers_replace = [
    aws_instance.catalogue.id
  ]

  #Make sure you've run aws configure on your laptop.
  provisioner "local-exec" {
    command =    "aws ec2 terminate-instances --instance-ids ${aws_instance.catalogue.id}"
  }
  depends_on = [ aws_ami_from_instance.catalogue ]
}
