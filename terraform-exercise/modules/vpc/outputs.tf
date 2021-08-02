output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "route_table_id" {
  value = aws_vpc.vpc.default_route_table_id
}

output "igw_id" {
  value = aws_internet_gateway.igw.id
}

output "dflt_sec_grp_id" {
  value = aws_vpc.vpc.default_security_group_id
}