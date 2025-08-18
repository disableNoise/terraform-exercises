provider "aws" {
  region = var.region
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "app_server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.level2_sg.id]

  tags = {
    Name = "hello-terraform"
  }
}

resource "aws_security_group" "level2_sg" {
  name        = "level2_sg"
  description = "Level 2 of exercises Level 2"

  tags = {
    Name = "level2_sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_just_me" {
  security_group_id = aws_security_group.level2_sg.id
  cidr_ipv4         = "190.151.61.204/32"
  from_port         = 20
  ip_protocol       = "tcp"
  to_port           = 20
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_all" {
  security_group_id = aws_security_group.level2_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}


resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.level2_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

