output "vpc-id" {
  description = "The VPC Identification"
  value       = aws_vpc.sscp_vpc_stg.id
}

output "sg-cloudflare-access-id" {
  description = "Security Groups detail"
  value       = aws_security_group.cloudflare_access_sg.id
}

output "sg-internal-access-id" {
  description = "Security Groups detail"
  value       = aws_security_group.internal_access_sg.id
}

output "sg-vpn-office-access-id" {
  description = "Security Groups detail"
  value       = aws_security_group.vpn_office_access_sg.id
}

output "route_table_main" {
  description = "Get the Main Route Table"
  value       = aws_vpc.sscp_vpc_stg.main_route_table_id

}

output "launch_template_id" {
  value = aws_launch_template.web_launch_template.id
}

output "launch_template_name" {
  value = aws_launch_template.web_launch_template.name
}

output "asg_desired_capacity" {
  value       = aws_autoscaling_group.aws_asg.desired_capacity
  description = "The desired capacity of the auto scaling group; it may be useful when doing blue/green asg deployment (create a new asg while copying the old's capacity)"
}

output "asg_name" {
  value       = aws_autoscaling_group.aws_asg.name
  description = "The name of the auto scaling group"
}

output "aws_launch_template_id" {
  description = "template id"
  value       = aws_launch_template.web_launch_template.id
}

output "private_subnet_ids" {
  value = {
    for k, subnet in aws_subnet.private_subnet : k => subnet.id
  }
}

output "public_subnet_ids" {
  value = {
    for k, subnet in aws_subnet.public_subnet : k => subnet.id
  }
}

output "rds_name" {
  description = "RDS name"
  value       = aws_db_instance.sscp_rds.db_name
}

output "rds_port" {
  description = "RDS instance port"
  value       = aws_db_instance.sscp_rds.port
}

output "rds_username" {
  description = "RDS instance username"
  value       = aws_db_instance.sscp_rds.username
}

output "rds_endpoint" {
  description = "Get AWS RDS instance endpoint"
  value       = aws_db_instance.sscp_rds.address

}

output "alb_url" {
  value = module.alb.lb_dns_name
}