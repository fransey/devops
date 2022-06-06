resource "aws_efs_file_system" "efs" {
  encrypted        = true
  performance_mode = var.performance_mode
  throughput_mode  = var.throughput_mode

  tags = {
    Name        = "${var.website_name}-efs-${var.env}"
    Environment = var.env
    Project     = var.project_name
  }
}
resource "aws_efs_mount_target" "mount" {
  count           = length(data.aws_availability_zones.available.names)
  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = aws_subnet.public_subnet[count.index].id
  security_groups = [aws_security_group.internal_access_sg.id]
}
