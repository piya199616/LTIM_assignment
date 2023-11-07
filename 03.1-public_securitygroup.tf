

module "public_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"


  name = "public_sg"

  vpc_id = module.vpc.vpc_id

 ingress_cidr_blocks = ["0.0.0.0/0"]

 ingress_rules = ["ssh-tcp"]

 egress_rules = ["all-all"]
}

