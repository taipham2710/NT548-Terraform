# VPC
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
  
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = module.vpc.vpc_cidr_block
  
}

# Subnets
output "public_subnet_id" {
  description = "The ID of the public subnet"
  value       = module.subnets.public_subnet_id
  
}

output "public_subnet_cidr_block" {
  description = "The CIDR block of the public subnet"
  value       = module.subnets.public_subnet_cidr
  
}

output "private_subnet_id" {
  description = "The ID of the private subnet"
  value       = module.subnets.private_subnet_id
  
}

output "private_subnet_cidr_block" {
  description = "The CIDR block of the private subnet"
  value       = module.subnets.private_subnet_cidr
  
}

# Internet Gateway
output "internet_gateway_id" {
  description = "The ID of the internet gateway"
  value       = module.internet-gateway.internet_gateway_id
  
}

# Nat Gateway
output "nat_gateway_id" {
  description = "The ID of the NAT gateway"
  value       = module.nat-gateway.nat_gateway_id
  
}

# Route Tables
output "public_route_table_id" {
  description = "The ID of the public route table"
  value       = module.route-tables.public_route_table_id
  
}

output "private_route_table_id" {
  description = "The ID of the private route table"
  value       = module.route-tables.private_route_table_id
  
}

# Security Groups
output "public_security_group_id" {
  description = "The ID of the public security group"
  value       = module.security-groups.public_security_group_id
  
}

output "private_security_group_id" {
  description = "The ID of the private security group"
  value       = module.security-groups.private_security_group_id
  
}

# EC2 Instance
output "public_instance_id" {
  description = "The ID of the EC2 instance"
  value       = module.ec2.public_instance_id
  
}

output "public_instance_ip" {
  description = "value of public instance ip"
  value = module.ec2.public_instance_ip
}

output "private_instance_id" {
  description = "The ID of the EC2 instance"
  value       = module.ec2.private_instance_id
  
}

output "private_instance_ip" {
  description = "value of private instance ip"
  value = module.ec2.private_instance_ip
}
