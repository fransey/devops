<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0.0 |
| <a name="requirement_cloudflare"></a> [cloudflare](#requirement\_cloudflare) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.0.0 |
| <a name="provider_template"></a> [template](#provider\_template) | 2.2.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_alb"></a> [alb](#module\_alb) | terraform-aws-modules/alb/aws | ~> 6.0 |

## Resources

| Name | Type |
|------|------|
| [aws_acm_certificate.alb_cert](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_autoscaling_group.aws_asg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) | resource |
| [aws_autoscaling_notification.asg_notifications](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_notification) | resource |
| [aws_db_instance.sscp_rds](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) | resource |
| [aws_db_subnet_group.rds_subnet_grp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |
| [aws_efs_file_system.efs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_file_system) | resource |
| [aws_efs_mount_target.mount](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_mount_target) | resource |
| [aws_eip.sscp_bastion_host_eip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_eip_association.eip_assoc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip_association) | resource |
| [aws_instance.sscp_bastion_host](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_internet_gateway.ig](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_launch_template.web_launch_template](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template) | resource |
| [aws_main_route_table_association.rt_main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/main_route_table_association) | resource |
| [aws_network_interface.bastion_if](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_interface) | resource |
| [aws_route_table.rt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.private_rt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public_rt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_security_group.cloudflare_access_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.internal_access_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.sg_bastion](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.vpn_office_access_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_sns_topic.asg_topic](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |
| [aws_subnet.private_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.sscp_vpc_stg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_ami_ids.amazon_linux_2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami_ids) | data source |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_subnets.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [aws_subnets.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [template_file.bastion_boot](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |
| [template_file.efs_mount](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alb_type"></a> [alb\_type](#input\_alb\_type) | n/a | `string` | `"application"` | no |
| <a name="input_allocated_storage"></a> [allocated\_storage](#input\_allocated\_storage) | The allocated storage in GBs | `number` | `null` | no |
| <a name="input_alternative_domains"></a> [alternative\_domains](#input\_alternative\_domains) | The alternatives domain names for ACM | `list(any)` | `[]` | no |
| <a name="input_asg_default_cooldown"></a> [asg\_default\_cooldown](#input\_asg\_default\_cooldown) | Time, in seconds, the minimum interval of two scaling activities | `string` | `""` | no |
| <a name="input_asg_desired_capacity"></a> [asg\_desired\_capacity](#input\_asg\_desired\_capacity) | The created ASG will have this number of instances at desired | `string` | `""` | no |
| <a name="input_asg_health_check_grace_period"></a> [asg\_health\_check\_grace\_period](#input\_asg\_health\_check\_grace\_period) | Time, in seconds, to wait for new instances before checking their health | `string` | `""` | no |
| <a name="input_asg_health_check_type"></a> [asg\_health\_check\_type](#input\_asg\_health\_check\_type) | Controls how ASG health checking is done | `string` | `""` | no |
| <a name="input_asg_max_capacity"></a> [asg\_max\_capacity](#input\_asg\_max\_capacity) | The created ASG will have this number of instances at maximum | `string` | `""` | no |
| <a name="input_asg_min_capacity"></a> [asg\_min\_capacity](#input\_asg\_min\_capacity) | The created ASG will have this number of instances at minimum | `string` | `""` | no |
| <a name="input_asg_notifications"></a> [asg\_notifications](#input\_asg\_notifications) | The notification array for the ASG | `list(any)` | `[]` | no |
| <a name="input_availability_zone"></a> [availability\_zone](#input\_availability\_zone) | The AZ for the RDS instance. Specify one of `subnet_ids`, `db_subnet_group_name` or `availability_zone`. If `availability_zone` is provided, the instance will be placed into the default VPC or EC2 Classic | `string` | `"full"` | no |
| <a name="input_aws-region"></a> [aws-region](#input\_aws-region) | The AWS region | `string` | `""` | no |
| <a name="input_backup_policy_status"></a> [backup\_policy\_status](#input\_backup\_policy\_status) | A status of the backup policy. | `string` | `""` | no |
| <a name="input_bastion_image_id"></a> [bastion\_image\_id](#input\_bastion\_image\_id) | The AMI (Amazon Machine Image) that identifies the instance | `string` | `"ami-0e8cb4bdc5bb2e6c0"` | no |
| <a name="input_cloudflare_api_token"></a> [cloudflare\_api\_token](#input\_cloudflare\_api\_token) | The Cloudflare API token. | `string` | `""` | no |
| <a name="input_cloudflare_email"></a> [cloudflare\_email](#input\_cloudflare\_email) | The email associated with the account | `string` | `""` | no |
| <a name="input_cloudflare_zone_id"></a> [cloudflare\_zone\_id](#input\_cloudflare\_zone\_id) | The Cloudflare zone id. | `string` | `""` | no |
| <a name="input_database_name"></a> [database\_name](#input\_database\_name) | The name of the database to create when the DB instance is created | `string` | `"superscommessecrownpeak"` | no |
| <a name="input_database_password"></a> [database\_password](#input\_database\_password) | Password for the master DB user | `string` | `"changeme"` | no |
| <a name="input_database_port"></a> [database\_port](#input\_database\_port) | Database port (\_e.g.\_ `3306` for `MySQL`). Used in the DB Security Group to allow access to the DB instance from the provided `security_group_ids` | `number` | `"3306"` | no |
| <a name="input_database_username"></a> [database\_username](#input\_database\_username) | Username for the master DB user | `string` | `"sscproot"` | no |
| <a name="input_db_parameter_group"></a> [db\_parameter\_group](#input\_db\_parameter\_group) | Parameter group, depends on DB engine used | `string` | `""` | no |
| <a name="input_db_subnet_group_name"></a> [db\_subnet\_group\_name](#input\_db\_subnet\_group\_name) | Name of DB subnet group. DB instance will be created in the VPC associated with the DB subnet group. Specify one of `subnet_ids`, `db_subnet_group_name` or `availability_zone` | `string` | `""` | no |
| <a name="input_delete_on_termination"></a> [delete\_on\_termination](#input\_delete\_on\_termination) | Whether the volume should be destroyed on instance termination | `bool` | `true` | no |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | The domain name for ACM | `string` | `""` | no |
| <a name="input_engine"></a> [engine](#input\_engine) | Database engine type | `string` | `""` | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | Database engine version, depends on engine type | `string` | `""` | no |
| <a name="input_env"></a> [env](#input\_env) | The AWS enviroment | `string` | `""` | no |
| <a name="input_iam_role_name"></a> [iam\_role\_name](#input\_iam\_role\_name) | The IAM role to assign to the instance | `string` | `""` | no |
| <a name="input_image_id"></a> [image\_id](#input\_image\_id) | AMI image identifier | `string` | `"ami-0e8cb4bdc5bb2e6c0"` | no |
| <a name="input_instance_ami"></a> [instance\_ami](#input\_instance\_ami) | The AMI (Amazon Machine Image) that identifies the instance | `string` | `""` | no |
| <a name="input_instance_associate_public_ip"></a> [instance\_associate\_public\_ip](#input\_instance\_associate\_public\_ip) | Defines if the EC2 instance has a public IP address. | `string` | `"true"` | no |
| <a name="input_instance_class"></a> [instance\_class](#input\_instance\_class) | Class of RDS instance | `string` | `""` | no |
| <a name="input_instance_key_name"></a> [instance\_key\_name](#input\_instance\_key\_name) | The name of the SSH key to associate to the instance. Note that the key must exist already. | `string` | `""` | no |
| <a name="input_instance_key_name_bastion"></a> [instance\_key\_name\_bastion](#input\_instance\_key\_name\_bastion) | The name of the SSH key to associate to the bastion instance. Note that the key must exist already. | `string` | `""` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | The instance type to be used | `string` | `"t3.medium"` | no |
| <a name="input_instance_type_bastion"></a> [instance\_type\_bastion](#input\_instance\_type\_bastion) | EC2 instance type for bastion host | `string` | `""` | no |
| <a name="input_major_engine_version"></a> [major\_engine\_version](#input\_major\_engine\_version) | Database MAJOR engine version, depends on engine type | `string` | `""` | no |
| <a name="input_metadata_v2"></a> [metadata\_v2](#input\_metadata\_v2) | Enforce metadata version 2 | `bool` | `true` | no |
| <a name="input_multi_az"></a> [multi\_az](#input\_multi\_az) | Set to true if multi AZ deployment must be supported | `bool` | n/a | yes |
| <a name="input_performance_mode"></a> [performance\_mode](#input\_performance\_mode) | The file system performance mode | `string` | `""` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | The project name | `string` | `""` | no |
| <a name="input_publicly_accessible"></a> [publicly\_accessible](#input\_publicly\_accessible) | Determines if database can be publicly available (NOT recommended) | `bool` | n/a | yes |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | List of security group names to attach | `list` | `[]` | no |
| <a name="input_storage_encrypted"></a> [storage\_encrypted](#input\_storage\_encrypted) | (Optional) Specifies whether the DB instance is encrypted. The default is false if not specified | `bool` | n/a | yes |
| <a name="input_storage_type"></a> [storage\_type](#input\_storage\_type) | One of 'standard' (magnetic), 'gp2' (general purpose SSD), or 'io1' (provisioned IOPS SSD) | `string` | `""` | no |
| <a name="input_subnet_cidr_public"></a> [subnet\_cidr\_public](#input\_subnet\_cidr\_public) | The CIDR block to associate to the subnet | `string` | `"10.0.0.0/24"` | no |
| <a name="input_throughput_mode"></a> [throughput\_mode](#input\_throughput\_mode) | Throughput mode for the file system | `string` | `""` | no |
| <a name="input_user_data"></a> [user\_data](#input\_user\_data) | Encoded user data | `any` | `null` | no |
| <a name="input_user_data_script"></a> [user\_data\_script](#input\_user\_data\_script) | The filepath to the user-data script, that is executed upon spinning up the instance | `string` | `""` | no |
| <a name="input_volume_size"></a> [volume\_size](#input\_volume\_size) | Size of the volume in gibibytes | `string` | `50` | no |
| <a name="input_volume_type"></a> [volume\_type](#input\_volume\_type) | Type of volume allocated to the bastion host | `string` | `"gp2"` | no |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | The CIDR block to associate to the VPC | `string` | `"10.0.0.0/16"` | no |
| <a name="input_website_name"></a> [website\_name](#input\_website\_name) | The website name | `string` | `""` | no |
| <a name="input_websites_region"></a> [websites\_region](#input\_websites\_region) | The websites region | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alb_url"></a> [alb\_url](#output\_alb\_url) | n/a |
| <a name="output_asg_desired_capacity"></a> [asg\_desired\_capacity](#output\_asg\_desired\_capacity) | The desired capacity of the auto scaling group; it may be useful when doing blue/green asg deployment (create a new asg while copying the old's capacity) |
| <a name="output_asg_name"></a> [asg\_name](#output\_asg\_name) | The name of the auto scaling group |
| <a name="output_aws_launch_template_id"></a> [aws\_launch\_template\_id](#output\_aws\_launch\_template\_id) | template id |
| <a name="output_efs-file-system-dns-name"></a> [efs-file-system-dns-name](#output\_efs-file-system-dns-name) | n/a |
| <a name="output_launch_template_id"></a> [launch\_template\_id](#output\_launch\_template\_id) | n/a |
| <a name="output_launch_template_name"></a> [launch\_template\_name](#output\_launch\_template\_name) | n/a |
| <a name="output_private_subnet_ids"></a> [private\_subnet\_ids](#output\_private\_subnet\_ids) | n/a |
| <a name="output_public_subnet_ids"></a> [public\_subnet\_ids](#output\_public\_subnet\_ids) | n/a |
| <a name="output_rds_endpoint"></a> [rds\_endpoint](#output\_rds\_endpoint) | Get AWS RDS instance endpoint |
| <a name="output_rds_name"></a> [rds\_name](#output\_rds\_name) | RDS name |
| <a name="output_rds_port"></a> [rds\_port](#output\_rds\_port) | RDS instance port |
| <a name="output_rds_username"></a> [rds\_username](#output\_rds\_username) | RDS instance username |
| <a name="output_route_table_main"></a> [route\_table\_main](#output\_route\_table\_main) | Get the Main Route Table |
| <a name="output_sg-cloudflare-access-id"></a> [sg-cloudflare-access-id](#output\_sg-cloudflare-access-id) | Security Groups detail |
| <a name="output_sg-internal-access-id"></a> [sg-internal-access-id](#output\_sg-internal-access-id) | Security Groups detail |
| <a name="output_sg-vpn-office-access-id"></a> [sg-vpn-office-access-id](#output\_sg-vpn-office-access-id) | Security Groups detail |
| <a name="output_vpc-id"></a> [vpc-id](#output\_vpc-id) | The VPC Identification |
<!-- END_TF_DOCS -->