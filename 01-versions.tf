
#Terraform Block
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }

    null = {
       source  = "hashicorp/null"
       version = "~> 3.2"
    }
  }
  backend "s3" {
    bucket = "mybucket-ltim"
    key    = "dev/ltim_state_file/terraform.state"
    region = "us-east-1"
  }

}


#Provider Block


provider "aws" {
  region = var.aws_region
}


