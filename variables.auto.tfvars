aws-region      = "eu-south-1"
websites_region = "eu"
website_name    = "sscp"
env             = "stg"
project_name    = "superscommesse-crownpeak"

# ALB
alb_type = "application"

# ACM
domain_name = "catenacloud.io"
alternative_domains = [
  "*.catenacloud.io"
]

# AMI
image_id         = "ami-02349ffb682ab1aee"
bastion_image_id = "ami-08c1cf9fe0a7ec4b6"

# EC2
instance_type             = "t3.medium"
instance_type_bastion     = "t3.medium"
instance_key_name         = "sscp-stg-key"
instance_key_name_bastion = "sscp-bastion-key"

#user_data_script = "./scripts/spinup.sh"
#iam_role_name    = "superscommesse-crownpeak-stg"

# ASG
asg_default_cooldown          = "300"
asg_desired_capacity          = "2"
asg_health_check_grace_period = "300"
asg_health_check_type         = "EC2"
asg_max_capacity              = "5"
asg_min_capacity              = "3"
asg_notifications = [
  "autoscaling:EC2_INSTANCE_LAUNCH",
  "autoscaling:EC2_INSTANCE_TERMINATE",
  "autoscaling:EC2_INSTANCE_LAUNCH_ERROR",
  "autoscaling:EC2_INSTANCE_TERMINATE_ERROR",
]

# EFS 
performance_mode = "generalPurpose"
throughput_mode  = "bursting"

# RDS
engine               = "mysql"
engine_version       = "8.0.27"
major_engine_version = "8.0"
instance_class       = "db.t3.micro"
db_parameter_group   = "mysql56"
publicly_accessible  = false
storage_encrypted    = true
storage_type         = "gp2"
allocated_storage    = "50"
multi_az             = false
