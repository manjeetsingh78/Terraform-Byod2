data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  owners = ["137112412989"] # Amazon
}

resource "aws_instance" "web_server" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public_subnet.id
  key_name      = aws_key_pair.mykey.key_name
  security_groups = [
    aws_security_group.web_sg.id
  ]

  user_data = file("userdata.sh")

  tags = {
    Name = "genesis-web-server"
  }
}
