provider "aws" {
  region = var.aws-region
}

terraform {
  backend "s3" {

    # S3 bucket configurations
    bucket = "terraform-crownpeak-ss-state"
    key    = "global/s3/terraform.tfstate"
    region = "eu-south-1"

    # DynamoDB table configurations
    dynamodb_table = "terraform-crownpeak-ss-locks"
    encrypt        = true
  }
}
