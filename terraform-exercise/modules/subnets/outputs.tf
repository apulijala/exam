output "public_subnets" {
  value = values(aws_subnet.public).*.id
}

output "private_subnets" {
  value = values(aws_subnet.private).*.id
}

output "private_subnets_map" {
  value = aws_subnet.public.*
}

