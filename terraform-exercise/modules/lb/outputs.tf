output "lb_dns" {
  value = aws_lb.my_alb.dns_name
}

output "tgt_grp_arn" {
  value = aws_lb_target_group.test.arn
}

output "alb_sec_grp_id" {
  value = aws_security_group.allow_tls.id
}