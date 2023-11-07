
resource "null_resource" "name" {
  
  depends_on = [module.public_ec2_instance]
  
  # Connection Block for Provisioners to connect to EC2 Instance
connection {
    type     = "ssh"
    user     = "ec2-user"
    password = ""
    host     = aws_eip.bastion_eip.public_ip
    private_key = file("terraform-key.pem")
  }


#File Provisioner--copy pem file to bastion host

provisioner "file" {

source      = "privatekey/terraform-key.pem"
destination = "/tmp/terraform-key.pem"

}

#using remote-exc am providing permission for pem file
provisioner "remote-exec" {
  inline = [
      "sudo chmod 400 /tmp/terraform-key.pem",
    ]
  
}
}


