provider "aws" {
  region = var.region
}

module "vpc" {
  source = "../modules/vpc"
  region = var.region
  vpc-cidr = var.vpc-cidr
}

module "subnets" {
  source = "../modules/subnets"
  private_subnets = var.private_subnets
  public_subnets = var.public_subnets
  region = var.region
  vpc_id = module.vpc.vpc_id
  default_rt_tbl_id = module.vpc.route_table_id
  gateway_id = module.vpc.igw_id

}

resource "aws_default_security_group" "def_sec_grp" {

  vpc_id = module.vpc.vpc_id
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol = "tcp"
    from_port =  22
    to_port   = 22
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol = "tcp"
    from_port =  80
    to_port   = 80
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]

  }
}

data "template_file" "launch_nginx" {
  template = "${file("${path.module}/launch_instance.sh")}"
}

module "instance" {
  source = "../modules/instance"
  ami_id = var.ami_ids[var.region]
  name = var.name
  key_name = var.key_name
  region = var.region
  sec_grp_ids = [module.vpc.dflt_sec_grp_id]
  subnet_id = module.subnets.public_subnets[0]
  user_data = data.template_file.launch_nginx.rendered

}

module "alb" {
  source = "../modules/lb"
  lb_name = var.lb_name
  vpc_id = module.vpc.vpc_id
  public_subnets = module.subnets.public_subnets

}

resource "aws_security_group_rule" "lb_rule" {
  from_port ="80"
  protocol = "tcp"
  security_group_id = aws_default_security_group.def_sec_grp.id
  to_port = "80"
  type              = "ingress"
  source_security_group_id = module.alb.alb_sec_grp_id
}



module "asg" {
  source = "../modules/asg"
  ami_id =  var.ami_ids[var.region]
  key_name = var.key_name
  region = var.region
  sec_grp_ids = [module.vpc.dflt_sec_grp_id]
  alb_tgt_id = module.alb.tgt_grp_arn

user_data                   = data.template_file.launch_nginx.rendered
  max = var.max
  min = var.min
  name_prefix = var.launch_name
  private_subnets = module.subnets.private_subnets
  asg_name = var.asg_name
  launch_name = var.launch_name


}

