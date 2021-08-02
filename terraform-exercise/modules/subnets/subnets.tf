provider "aws" {
  region = var.region
}

// public subnets start.

resource "aws_subnet" "public" {
  for_each = var.public_subnets
  cidr_block = each.value["cidr"]
  availability_zone = each.key
  vpc_id = var.vpc_id
  tags = {
    Name = each.value["name"]
  }
}

resource "aws_default_route_table" "default" {
  default_route_table_id = var.default_rt_tbl_id

}

resource "aws_route" "route_to_and_from_internet" {
  route_table_id = aws_default_route_table.default.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = var.gateway_id
}



// public subnets end.

// private subnets begin.

resource "aws_subnet" "private" {
  for_each = var.private_subnets
  cidr_block = each.value["cidr"]
  availability_zone = each.key
  vpc_id = var.vpc_id
  tags = {
    Name = each.value["name"]
  }
}
resource "aws_eip" "elastic_ip" {
  count =  length(keys(aws_subnet.private))

}

resource "aws_nat_gateway" "example" {

  #count =  length(values(aws_subnet.public))
  # count =  length(keys(var.private_subnets)) ths worked
  count =  length(keys(aws_subnet.private)) # This did not work before
  allocation_id = aws_eip.elastic_ip[count.index].id # count.index # element(aws_eip.elastic_ip.*.id, count.index)
  subnet_id  = element(values(aws_subnet.public).*.id, count.index)

  tags = {
    Name =  format("%s--%s","gw NAT", count.index )
  }
}

// private subnets end.

resource "aws_route_table" "private_rt_table" {
  count = length(keys(aws_subnet.private))
  vpc_id = var.vpc_id
  tags = {
    "Name" = format("%s--%s","private route table", count.index )
  }

}

resource "aws_route_table_association" "private_rt_associ" {
  count = length(aws_route_table.private_rt_table)
  route_table_id = aws_route_table.private_rt_table[count.index].id
  subnet_id = values(aws_subnet.private)[count.index].id

}

resource "aws_route" "private_rt" {
  count = length(aws_route_table.private_rt_table)
  route_table_id = element(aws_route_table.private_rt_table.*.id , count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.example[count.index].id
  #depends_on = [aws_nat_gateway.example[count.index].id]

}

