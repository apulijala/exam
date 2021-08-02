output "dns_name" {
  value = aws_instance.instance.public_dns
}