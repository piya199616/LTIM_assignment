
module "public_ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.5.0"

  depends_on = [module.vpc]
  name = "public_vm"
  ami = data.aws_ami.amzlinux.id
  instance_type          = "t2.micro"
  key_name               = "terraform-key"
  #count = 2
  monitoring             = true
  vpc_security_group_ids = [module.public_security_group.security_group_id]
 # subnet_id              = element(module.vpc.public_subnets,count.index)
  subnet_id = module.vpc.public_subnets[0]


}