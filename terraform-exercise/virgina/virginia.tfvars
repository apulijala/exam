region="us-east-1"

vpc-cidr = "192.168.0.0/24"

name  = "Bastion"


public_subnets = {
  "us-east-1a" : {
    "name": "subnet-public-a" ,
    "cidr": "192.168.0.0/27"
  },
  "us-east-1b": {
    "name":  "subnet-public-b" ,
    "cidr": "192.168.0.32/27"
  },
  "us-east-1c": {
    "name":  "subnet-public-c" ,
    "cidr": "192.168.0.64/27"
  },
  "us-east-1d": {
    "name":  "subnet-public-c" ,
    "cidr": "192.168.0.96/27"

  }
}

private_subnets = {
  "us-east-1a" : {
    "name": "subnet-public-a" ,
    "cidr": "192.168.0.128/27"
  },
  "us-east-1b": {
    "name":  "subnet-public-b" ,
    "cidr": "192.168.0.160/27"
  },
  "us-east-1c": {
    "name":  "subnet-public-c" ,
    "cidr": "192.168.0.192/27"
  },
  "us-east-1d": {
    "name":  "subnet-public-c" ,
    "cidr": "192.168.0.224/27"

  }

}
lb_name = "virginia-lb"
launch_name = "virginia-lnch"
max = 4
min = 2
name_prefix = "virginia"
asg_name = "virginia_asg"
key_name = "demo_virginia"