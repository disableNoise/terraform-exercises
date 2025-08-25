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


#### modules ####

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  name = "single-instance"
  instance_type = "t3.micro"
  ami = "data.aws_ami.ubuntu.id"
  subnet_id = "subnet-0f82a71265c08273e"
  tags = {
    Name = "hello-terraform"
  }
}

