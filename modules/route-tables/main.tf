# Create a route table for the public subnet and associate it with the public subnet
resource "aws_route_table" "public" { 
  vpc_id = var.vpc_id
  tags = {
    Name = "PublicRouteTable"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.gw_id
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = var.public_subnet_id
  route_table_id = aws_route_table.public.id
}


resource "aws_route_table" "private" {
  vpc_id = var.vpc_id
  tags = {
    Name = "PrivateRouteTable"
  }
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = var.nat_id
  }
}

resource "aws_route_table_association" "private" {
  subnet_id      = var.private_subnet_id
  route_table_id = aws_route_table.private.id
}
