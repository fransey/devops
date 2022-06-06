resource "aws_autoscaling_group" "aws_asg" {
  name                      = "${var.website_name}-asg-${var.env}"
  max_size                  = var.asg_max_capacity
  min_size                  = var.asg_min_capacity
  desired_capacity          = var.asg_desired_capacity
  default_cooldown          = var.asg_default_cooldown
  health_check_grace_period = var.asg_health_check_grace_period
  health_check_type         = var.asg_health_check_type
  target_group_arns         = [module.alb.target_group_arns[0]]
  vpc_zone_identifier       = [aws_subnet.public_subnet[0].id, aws_subnet.public_subnet[1].id, aws_subnet.public_subnet[2].id]

  launch_template {
    id      = aws_launch_template.web_launch_template.id
    version = "$Latest"
  }

  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = "${var.website_name}-asg-${var.env}"
    propagate_at_launch = true
  }

  tag {
    key                 = "Environment"
    value               = var.env
    propagate_at_launch = true
  }

  tag {
    key                 = "Project"
    value               = var.project_name
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_notification" "asg_notifications" {
  group_names = [
    aws_autoscaling_group.aws_asg.name,
  ]

  notifications = var.asg_notifications

  topic_arn = aws_sns_topic.asg_topic.arn
}

resource "aws_sns_topic" "asg_topic" {
  name = "${var.website_name}-notifications-auto-scale-group-${var.env}"
}

resource "aws_network_interface" "bastion_if" {
  subnet_id       = aws_subnet.public_subnet[0].id
  security_groups = [aws_security_group.sg_bastion.id]
  tags = {
    Name = "primary_network_interface"
  }
}

resource "aws_instance" "sscp_bastion_host" {
  ami           = var.bastion_image_id
  ebs_optimized = true
  instance_type = var.instance_type_bastion
  key_name      = var.instance_key_name_bastion
  user_data     = base64encode(data.template_file.bastion_boot.rendered)


  network_interface {
    network_interface_id = aws_network_interface.bastion_if.id
    device_index         = 0
  }

  tags = {
    Name        = "${var.website_name}-bastion-host"
    Environment = var.env
    Project     = var.project_name
  }

  root_block_device {
    volume_type           = var.volume_type
    volume_size           = var.volume_size
    delete_on_termination = var.delete_on_termination
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [user_data]
  }

}

resource "aws_eip" "sscp_bastion_host_eip" {
  vpc        = true
  instance   = aws_instance.sscp_bastion_host.id
  depends_on = [aws_internet_gateway.ig]

  tags = {
    Name        = "${var.website_name}-bastion-host-eip"
    Environment = var.env
    Project     = var.project_name
  }
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.sscp_bastion_host.id
  allocation_id = aws_eip.sscp_bastion_host_eip.id
}
