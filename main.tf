provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source   = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
}

module "subnets" {
  source              = "./modules/subnets"
  vpc_id              = module.vpc.vpc_id
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
}

module "nat-gateway" {
  source           = "./modules/nat-gateway"
  vpc_id           = module.vpc.vpc_id
  public_subnet_id = module.subnets.public_subnet_id
}

module "internet-gateway" {
  source = "./modules/internet-gateway"
  vpc_id = module.vpc.vpc_id
}

module "route-tables" {
  source            = "./modules/route-tables"
  vpc_id            = module.vpc.vpc_id
  private_subnet_id = module.subnets.private_subnet_id
  public_subnet_id  = module.subnets.public_subnet_id
  nat_id            = module.nat-gateway.nat_gateway_id
  gw_id             = module.internet-gateway.internet_gateway_id
}

module "security-groups" {
  source             = "./modules/security-groups"
  vpc_id             = module.vpc.vpc_id
  public_subnet_cidr = module.subnets.public_subnet_cidr
}

// generate a random suffix for the key name to avoid collisions after multiple runs
resource "random_id" "suffix" {
  byte_length = 4
}

resource "aws_key_pair" "deployer" {
  key_name   = "secret-key-${random_id.suffix.hex}"
  public_key = file(var.public_key_path)
}

module "ec2" {
  source                    = "./modules/ec2"
  private_security_group_id = module.security-groups.private_security_group_id
  public_security_group_id  = module.security-groups.public_security_group_id
  public_subnet_id          = module.subnets.public_subnet_id
  private_subnet_id         = module.subnets.private_subnet_id
  aws_key_pair              = aws_key_pair.deployer.key_name
}