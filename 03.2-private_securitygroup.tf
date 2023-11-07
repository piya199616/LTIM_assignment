
module "private_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"


  name = "private_sg"

  vpc_id = module.vpc.vpc_id

 ingress_cidr_blocks = [module.vpc.vpc_cidr_block]

 ingress_rules = ["ssh-tcp" , "http-80-tcp"]

 egress_rules = ["all-all"]
}
