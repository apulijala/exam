output "vpc_id" {
  value = module.vpc.vpc_id
}

output "subnet_ids" {
  value = module.subnets.public_subnets
}

output "nginx_domain" {
  value = module.instance.dns_name
}


output "private_subnet_map" {
  value = module.subnets.private_subnets_map
}

output "lb_dns" {
  value = module.alb.lb_dns
}

output "tgt_grp_arn" {
  value = module.alb.tgt_grp_arn
}