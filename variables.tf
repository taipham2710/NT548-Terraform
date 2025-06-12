variable "aws_region" {
  default     = "us-east-1"
  description = "AWS region to deploy resources in"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  default = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  default = "10.0.2.0/24"
}

variable "public_key" {
  description = "SSH public key"
  type        = string
}
