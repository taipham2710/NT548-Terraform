resource "aws_internet_gateway" "gw" {
  vpc_id = var.main.id
}