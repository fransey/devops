variable "aws-region" {
  description = "The AWS region"
  type        = string
  default     = ""
}

variable "websites_region" {
  description = "The websites region"
  type        = string
  default     = ""
}

variable "website_name" {
  description = "The website name"
  type        = string
  default     = ""
}

variable "env" {
  description = "The AWS enviroment"
  type        = string
  default     = ""
}

variable "project_name" {
  description = "The project name"
  type        = string
  default     = ""
}

# Bastion EC2

variable "volume_type" {
  type        = string
  default     = "gp2"
  description = "Type of volume allocated to the bastion host"
}

variable "volume_size" {
  type        = string
  description = "Size of the volume in gibibytes"
  default     = 50
}

variable "delete_on_termination" {
  type        = bool
  description = "Whether the volume should be destroyed on instance termination"
  default     = true
}

variable "bastion_image_id" {
  description = "The AMI (Amazon Machine Image) that identifies the instance"
  type        = string
  default     = "ami-0e8cb4bdc5bb2e6c0"
}

variable "instance_key_name_bastion" {
  description = "The name of the SSH key to associate to the bastion instance. Note that the key must exist already."
  type        = string
  default     = ""
}

variable "instance_type_bastion" {
  description = "EC2 instance type for bastion host"
  default     = ""
}

# EC2
variable "instance_ami" {
  description = "The AMI (Amazon Machine Image) that identifies the instance"
  type        = string
  default     = ""
}

variable "instance_type" {
  description = "The instance type to be used"
  type        = string
  default     = "t3.medium"
}

variable "instance_key_name" {
  description = "The name of the SSH key to associate to the instance. Note that the key must exist already."
  type        = string
  default     = ""
}

variable "metadata_v2" {
  description = "Enforce metadata version 2"
  default     = true
}

variable "image_id" {
  description = "AMI image identifier"
  default     = "ami-0e8cb4bdc5bb2e6c0"
}

variable "user_data" {
  description = "Encoded user data"
  default     = null
}

variable "iam_role_name" {
  description = "The IAM role to assign to the instance"
  type        = string
  default     = ""
}

variable "instance_associate_public_ip" {
  description = "Defines if the EC2 instance has a public IP address."
  type        = string
  default     = "true"
}

variable "user_data_script" {
  description = "The filepath to the user-data script, that is executed upon spinning up the instance"
  type        = string
  default     = ""
}


# VPC
variable "vpc_cidr_block" {
  description = "The CIDR block to associate to the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr_public" {
  description = "The CIDR block to associate to the subnet"
  type        = string
  default     = "10.0.0.0/24"
}

variable "security_groups" {
  description = "List of security group names to attach"
  default     = []
}

# EFS

variable "performance_mode" {
  description = "The file system performance mode"
  type        = string
  default     = ""
}

variable "throughput_mode" {
  description = "Throughput mode for the file system"
  type        = string
  default     = ""
}

variable "backup_policy_status" {
  description = "A status of the backup policy. "
  type        = string
  default     = ""
}

#ALB

variable "alb_type" {
  type    = string
  default = "application"
}


# Cloudflare
variable "cloudflare_email" {
  description = "The email associated with the account"
  type        = string
  sensitive   = true
  default     = ""
}

variable "cloudflare_api_token" {
  description = "The Cloudflare API token."
  type        = string
  sensitive   = true
  default     = ""
}

variable "cloudflare_zone_id" {
  description = "The Cloudflare zone id."
  type        = string
  sensitive   = true
  default     = ""
}

# ACM 
variable "domain_name" {
  description = "The domain name for ACM"
  type        = string
  default     = ""
}

variable "alternative_domains" {
  description = "The alternatives domain names for ACM"
  type        = list(any)
  default     = []
}

# ASG
variable "asg_min_capacity" {
  type        = string
  default     = ""
  description = "The created ASG will have this number of instances at minimum"
}

variable "asg_max_capacity" {
  type        = string
  default     = ""
  description = "The created ASG will have this number of instances at maximum"
}

variable "asg_desired_capacity" {
  type        = string
  default     = ""
  description = "The created ASG will have this number of instances at desired"
}

variable "asg_health_check_type" {
  type        = string
  default     = ""
  description = "Controls how ASG health checking is done"
}

variable "asg_health_check_grace_period" {
  type        = string
  default     = ""
  description = "Time, in seconds, to wait for new instances before checking their health"
}

variable "asg_default_cooldown" {
  type        = string
  default     = ""
  description = "Time, in seconds, the minimum interval of two scaling activities"
}

variable "asg_notifications" {
  type        = list(any)
  description = "The notification array for the ASG"
  default     = []
}

# RDS 

variable "database_name" {
  type        = string
  description = "The name of the database to create when the DB instance is created"
  default     = "superscommessecrownpeak"
}

variable "database_username" {
  type        = string
  description = "Username for the master DB user"
  default     = "sscproot"
}

variable "database_password" {
  type        = string
  description = "Password for the master DB user"
  default     = "changeme"
}

variable "database_port" {
  type        = number
  description = "Database port (_e.g._ `3306` for `MySQL`). Used in the DB Security Group to allow access to the DB instance from the provided `security_group_ids`"
  default     = "3306"
}

variable "multi_az" {
  type        = bool
  description = "Set to true if multi AZ deployment must be supported"
}

variable "availability_zone" {
  type        = string
  default     = "full"
  description = "The AZ for the RDS instance. Specify one of `subnet_ids`, `db_subnet_group_name` or `availability_zone`. If `availability_zone` is provided, the instance will be placed into the default VPC or EC2 Classic"
}

variable "db_subnet_group_name" {
  type        = string
  default     = ""
  description = "Name of DB subnet group. DB instance will be created in the VPC associated with the DB subnet group. Specify one of `subnet_ids`, `db_subnet_group_name` or `availability_zone`"
}

variable "storage_type" {
  type        = string
  description = "One of 'standard' (magnetic), 'gp2' (general purpose SSD), or 'io1' (provisioned IOPS SSD)"
  default     = ""
}

variable "storage_encrypted" {
  type        = bool
  description = "(Optional) Specifies whether the DB instance is encrypted. The default is false if not specified"
}

variable "allocated_storage" {
  type        = number
  description = "The allocated storage in GBs"
  default     = null
}

variable "engine" {
  type        = string
  description = "Database engine type"
  default     = ""
}

variable "engine_version" {
  type        = string
  description = "Database engine version, depends on engine type"
  default     = ""
}

variable "major_engine_version" {
  type        = string
  description = "Database MAJOR engine version, depends on engine type"
  default     = ""
}

variable "instance_class" {
  type        = string
  description = "Class of RDS instance"
  default     = ""
}

variable "db_parameter_group" {
  type        = string
  description = "Parameter group, depends on DB engine used"
  default     = ""
}

variable "publicly_accessible" {
  type        = bool
  description = "Determines if database can be publicly available (NOT recommended)"
}
