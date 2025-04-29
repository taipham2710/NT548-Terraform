variable "public_subnet_id" {}

variable "private_subnet_id" {}

variable "aws_key_pair" {
  
}

variable "ami_id" {
  default = "ami-0c55b159cbfafe1f0" # Amazon Linux 2
}

variable "instance_type" {
  default = "t2.micro"
}

variable "public_security_group_id" {
}

variable "private_security_group_id" {}   