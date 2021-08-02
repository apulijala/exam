provider "aws" {
  region = var.region
}

resource "aws_launch_configuration" "launch_config" {
  image_id =var.ami_id
  instance_type = "t2.micro"
  associate_public_ip_address = true
  user_data = var.user_data
  security_groups = var.sec_grp_ids
  name_prefix = var.name_prefix
  key_name = var.key_name
  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_autoscaling_group" "asg" {
 # This is important for rolling updates.
  name = "autoscaling-${aws_launch_configuration.launch_config.name}"
  max_size = var.max
  min_size = var.min
  launch_configuration = aws_launch_configuration.launch_config.name
  vpc_zone_identifier = var.private_subnets
  load_balancers = []
  health_check_type = "ELB"
  force_delete              = true
  health_check_grace_period = 300


  lifecycle {
    create_before_destroy = true

  }
  tag {
    key = "Name"
    propagate_at_launch = false
    value = var.asg_name
  }
}

resource "aws_autoscaling_attachment" "attachment" {

  autoscaling_group_name = aws_autoscaling_group.asg.name
  alb_target_group_arn = var.alb_tgt_id

}
