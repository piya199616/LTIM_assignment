

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.2"


  name = var.aws_vpc_name
  cidr = var.aws_vpc_cidr

  azs             = var.aws_az
  private_subnets = var.aws_private_subnet
  public_subnets  = var.aws_public_subnet


  enable_nat_gateway = true
  single_nat_gateway = true

  enable_dns_hostnames = true
  enable_dns_support   = true


  tags = {
    environment = "dev_env_tag"

  }

  vpc_tags = {

    name = "dev_vpc_tag"
  }
}

