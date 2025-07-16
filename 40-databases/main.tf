resource "aws_instance" "mongodb" {
  ami           = local.ami_id
  instance_type = "t3.micro"
  vpc_security_group_ids = [local.mongodb_sg]
  subnet_id = local.database_subnet_ids

  tags = merge(
    local.common_tags,
    {
        Name = "${var.project}-${var.environment}-${var.mongodb_sg_name}"
    }
  )
}

resource "terraform_data" "mongodb" {
  triggers_replace = [
    aws_instance.mongodb.id
  ]

  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.mongodb.private_ip
    }

  provisioner "file" {
    source      = "bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
  }

  provisioner "remote-exec" {
    inline = [ 
        "chmod +x /tmp/bootstrap.sh",
        "sudo sh /tmp/bootstrap.sh mongodb ${var.environment}"
     ]
  }
}





resource "aws_instance" "redis" {
  ami           = local.ami_id
  instance_type = "t3.micro"
  vpc_security_group_ids = [local.redis_sg]
  subnet_id = local.database_subnet_ids

  tags = merge(
    local.common_tags,
    {
        Name = "${var.project}-${var.environment}-${var.redis_sg_name}"
    }
  )
}

resource "terraform_data" "redis" {
  triggers_replace = [
    aws_instance.redis.id
  ]

  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.redis.private_ip
    }

  provisioner "file" {
    source      = "bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
  }

  provisioner "remote-exec" {
    inline = [ 
        "chmod +x /tmp/bootstrap.sh",
        "sudo sh /tmp/bootstrap.sh redis ${var.environment}"
     ]
  }
}





resource "aws_instance" "mysql" {
  ami           = local.ami_id
  instance_type = "t3.micro"
  vpc_security_group_ids = [local.mysql_sg]
  subnet_id = local.database_subnet_ids

  tags = merge(
    local.common_tags,
    {
        Name = "${var.project}-${var.environment}-${var.mysql_sg_name}"
    }
  )
}

resource "terraform_data" "mysql" {
  triggers_replace = [
    aws_instance.mysql.id
  ]

  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.mysql.private_ip
    }

  provisioner "file" {
    source      = "bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
  }

  provisioner "remote-exec" {
    inline = [ 
        "chmod +x /tmp/bootstrap.sh",
        "sudo sh /tmp/bootstrap.sh mysql ${var.environment}"
     ]
  }
}










resource "aws_instance" "rabbitmq" {
  ami           = local.ami_id
  instance_type = "t3.micro"
  vpc_security_group_ids = [local.rabbitmq_sg]
  subnet_id = local.database_subnet_ids

  tags = merge(
    local.common_tags,
    {
        Name = "${var.project}-${var.environment}-${var.rabbitmq_sg_name}"
    }
  )
}

resource "terraform_data" "rabbitmq" {
  triggers_replace = [
    aws_instance.rabbitmq.id
  ]

  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.rabbitmq.private_ip
    }

  provisioner "file" {
    source      = "bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
  }

  provisioner "remote-exec" {
    inline = [ 
        "chmod +x /tmp/bootstrap.sh",
        "sudo sh /tmp/bootstrap.sh rabbitmq ${var.environment}"
     ]
  }
}