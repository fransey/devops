resource "aws_db_subnet_group" "rds_subnet_grp" {
  name        = "${var.website_name}-rds-subnet-group"
  subnet_ids  = [aws_subnet.private_subnet[0].id, aws_subnet.private_subnet[1].id, aws_subnet.private_subnet[2].id]
  description = "Subnet for RDS instance"

}

resource "aws_db_instance" "sscp_rds" {
  identifier                = "${var.website_name}-infra-${var.env}"
  engine                    = var.engine
  engine_version            = var.engine_version
  instance_class            = var.instance_class
  publicly_accessible       = false
  allocated_storage         = var.allocated_storage
  storage_type              = var.storage_type
  storage_encrypted         = var.storage_encrypted
  db_name                   = var.database_name
  username                  = var.database_username
  password                  = var.database_password
  port                      = var.database_port
  multi_az                  = var.multi_az
  db_subnet_group_name      = aws_db_subnet_group.rds_subnet_grp.name
  vpc_security_group_ids    = [aws_security_group.internal_access_sg.id]
  skip_final_snapshot       = true
  final_snapshot_identifier = "${var.website_name}-snapshot"
}