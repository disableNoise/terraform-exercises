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
  vpc_security_group_ids = [aws_security_group.level3_sg.id]
  key_name	= aws_key_pair.generated_key.key_name

  user_data = <<-EOL
    #!/bin/bash -xe
    touch $HOME/test
    apt install apache2 -y
    echo "hola mundo cruel" > /var/www/html/index.html
    systemctl restart apache2
  EOL

  tags = {
    Name = "hello-terraform"
  }
}

#### security group ####

resource "aws_security_group" "level3_sg" {
  name        = "level3_sg"
  description = "Level 3 of exercises Level 2"

  tags = {
    Name = "level2_sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_just_me" {
  security_group_id = aws_security_group.level3_sg.id
  cidr_ipv4         = "190.151.61.204/32"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_all" {
  security_group_id = aws_security_group.level3_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}


resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.level3_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

#### key pair ####

resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name = "aws_keys_pairs"
  public_key = tls_private_key.example.public_key_openssh
}
