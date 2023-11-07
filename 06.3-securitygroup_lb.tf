module "lb_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"


  name = "loadbalancer_sg"

  vpc_id = module.vpc.vpc_id

 ingress_cidr_blocks = ["0.0.0.0/0"]

 ingress_rules = ["http-80-tcp"]

 egress_rules = ["all-all"]

 ingress_with_cidr_blocks = [
{

  from_port = 81
  to_port = 81
  protocol = 6
  cidr_blocks = "0.0.0.0/0"
}

 ]
}
