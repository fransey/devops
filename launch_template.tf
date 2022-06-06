resource "aws_launch_template" "web_launch_template" {
  name                   = "${var.website_name}-lt-${var.env}"
  image_id               = var.image_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.internal_access_sg.id]
  key_name               = var.instance_key_name

  depends_on = [
    aws_efs_file_system.efs
  ]
  user_data = base64encode(data.template_file.efs_mount.rendered)

  tags = {
    Environment = var.env
    Project     = var.project_name
  }

  lifecycle {
    ignore_changes = [user_data]
  }
}
