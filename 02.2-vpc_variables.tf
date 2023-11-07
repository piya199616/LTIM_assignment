
variable "aws_vpc_name" {

    type = string
    default = "dev_vpc_name"
  
}

variable "aws_vpc_cidr" {
   type = string
   default = "10.0.0.0/16"
  
}

variable "aws_az" {
    type = list(string)
    default = [ "us-east-1a", "us-east-1b"]

  
}

variable "aws_public_subnet" {
    type = list(string)
    default = ["10.0.101.0/24", "10.0.102.0/24"]
  
}

variable "aws_private_subnet" {

  type = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

