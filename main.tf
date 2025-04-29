provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
}

module "subnets" {
  source              = "./modules/subnets"
  vpc_id              = aws_vpc.main.id
  public_subnet_cidr  = module.subnets.public_subnet_cidr
  private_subnet_cidr = module.subnets.private_subnet_cidr
}

module "nat-gateway" {
  source = "./modules/nat-gateway"
  vpc_id = aws_vpc.main.id
  public_subnet_id = module.subnets.public_subnet_id
}

module "aws_internet_gateway" {
  source = "./modules/internet-gateway"
  vpc_id = aws_vpc.main.id
}

module "route-tables" {
  source = "./modules/route-tables"
  vpc_id = aws_vpc.main.id
  private_subnet_id = module.subnets.private_subnet_id
  public_subnet_id  = module.subnets.public_subnet_id
  nat_id            = module.nat-gateway.nat_id
  gw_id             = module.aws_internet_gateway.gw_id
}

module "security-groups" {
  source = "./modules/security-groups"
  vpc_id = aws_vpc.main.id
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = file(var.public_key_path)
}

module "ec2" {
  source                   = "./modules/ec2"
  private_security_group_id = module.security-groups.private_security_group_id
  public_security_group_id  = module.security-groups.public_security_group_id
  public_subnet_id          = module.subnets.public_subnet_id
  private_subnet_id         = module.subnets.private_subnet_id
  aws_key_pair              = aws_key_pair.deployer.key_name
}