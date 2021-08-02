variable "region" {}
variable "vpc-cidr" {}
variable "private_subnets" {}
variable "public_subnets" {}
variable "key_name" {}
variable "name" {}
variable "ami_ids" {
  type = map(string)
  default = {
    "eu-west-1" : "ami-cdbfa4ab",
    "us-east-1"    :"ami-50c0ea46"
  }
}
variable "lb_name" {}

variable "launch_name" {}
variable "max" {}
variable "min" {}
variable "name_prefix" {}
variable "asg_name" {}




