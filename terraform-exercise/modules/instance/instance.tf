provider "aws" {
  region = var.region
}

resource "aws_instance" "instance" {
  ami = var.ami_id
  instance_type = "t2.micro"
  associate_public_ip_address = true
  user_data = var.user_data
  subnet_id = var.subnet_id
  vpc_security_group_ids = var.sec_grp_ids
  key_name = var.key_name
  tags = {
    "Name" = var.name
  }
}