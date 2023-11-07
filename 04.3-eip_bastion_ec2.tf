
resource "aws_eip" "bastion_eip" {

  depends_on = [ 
    module.vpc,
    module.public_ec2_instance 
    ]
  
  instance = module.public_ec2_instance.id
  domain   = "vpc"


}