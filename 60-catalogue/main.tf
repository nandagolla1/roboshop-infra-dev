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
  subnet_id = local.private_subnets_id

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

  #####Make sure you've run aws configure on your laptop.
  provisioner "local-exec" {
    command =    "aws ec2 terminate-instances --instance-ids ${aws_instance.catalogue.id}"
  }
  depends_on = [ aws_ami_from_instance.catalogue ]
}


# aws launch template
resource "aws_launch_template" "catalogue" {
  name = "${var.project}-${var.environment}-catalogue"
  image_id = aws_ami_from_instance.catalogue.id
  instance_initiated_shutdown_behavior = "terminate"
  instance_type = "t3.micro"
  vpc_security_group_ids = [local.catalogue_sg]
  update_default_version = true # each time you update, new version will become default

  tag_specifications {
    resource_type = "instance"
    # EC2 tags created by ASG
    tags = merge(
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}-catalogue"
    }
  )
  }

  tag_specifications {
  resource_type = "volume"

  tags = merge(
  local.common_tags,
  {
    Name = "${var.project}-${var.environment}-catalogue"
  }
  )
 }

 tags = merge(
  local.common_tags,
  {
    Name = "${var.project}-${var.environment}-catalogue"
  }
  )
}


##auto scaling group for catalogue
resource "aws_autoscaling_group" "catalogue" {
  name                      = "${var.project}-${var.environment}-catalogue"
  max_size                  = 5
  min_size                  = 1
  health_check_grace_period = 120
  health_check_type         = "ELB"
  desired_capacity          = 1
  force_delete              = true
  ##placement_group           = aws_placement_group.test.id
  target_group_arns         = [aws_lb_target_group.catalogue.arn]
  vpc_zone_identifier       = [local.private_subnets_ids]

  launch_template {
    id = aws_ami_from_instance.catalogue.id
    version = "$Latest"
  }

  dynamic "tags" {
    for_each = merge(
      local.common_tags,
      {
        Name = "${var.project}-${var.environment}-catalogue"
      }
    )
    content{
      key = tags.key
      value = tags.value
      propagate_at_launch = true
    }
  }

    instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
    triggers = ["launch_template"]
  }

    timeouts{
    delete = "15m"
  }  
}


resource "aws_autoscaling_policy" "catalogue" {
  name                   = "${var.project}-${var.environment}-catalogue"
  autoscaling_group_name = aws_autoscaling_group.catalogue.name
  policy_type = "TargetTrackingScaling"
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 75.0
  }

} 


##  alb listener rule for catalogue target group
resource "aws_lb_listener_rule" "catalogue" {
  listener_arn = local.backend_alb_listener_arn
  priority     = 10

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.catalogue.arn
  }

  condition {
    host_header {
      values = ["catalogue.backend-${var.environment}.${var.domain_name}"]
    }
  }
}