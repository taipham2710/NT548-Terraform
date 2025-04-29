
resource "aws_subnet" "public" {
  vpc_id     = var.vpc_id
  cidr_block = var.public_subnet_cidr
  map_public_ip_on_launch = true # Enable public IP assignment
}

resource "aws_subnet" "private" {
  vpc_id     = var.vpc_id
  cidr_block = var.private_subnet_cidr
}
