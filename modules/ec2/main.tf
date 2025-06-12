
resource "aws_instance" "public" {
  ami             = var.ami_id # Amazon Linux 2
  instance_type   = var.instance_type
  subnet_id       = var.public_subnet_id
  key_name        = var.aws_key_pair
  security_groups = [var.public_security_group_id]
  tags = {
    Name = "PublicEC2"
  }
}

resource "aws_instance" "private" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.private_subnet_id
  key_name               = var.aws_key_pair
  vpc_security_group_ids = [var.private_security_group_id]
  tags = {
    Name = "PrivateEC2"
  }
}
