resource "aws_vpc" "autoscalling_vpc" {
  cidr_block = "172.16.0.0/16"
  tags = {
    Name = "autoscalling-vpc"
  }
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id            = aws_vpc.autoscalling_vpc.id
  cidr_block        = lookup(var.cidr_ranges, "public1")
  availability_zone = var.availability_zones.zone_a
  tags = {
    Name = "public-subnet-1"
  }
}

resource "aws_route_table" "route_table_1_public" {
  vpc_id = aws_vpc.autoscalling_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.autoscalling_gateway.id
  }
  tags = {
    Name = "route-table-public-1"
  }
}

resource "aws_route_table_association" "route_table_accociate_1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.route_table_1_public.id
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id            = aws_vpc.autoscalling_vpc.id
  cidr_block        = lookup(var.cidr_ranges, "public2")
  availability_zone = var.availability_zones.zone_b
  tags = {
    Name = "public-subnet-2"
  }
}
resource "aws_route_table" "route_table_2_public" {
  vpc_id = aws_vpc.autoscalling_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.autoscalling_gateway.id
  }
  tags = {
    Name = "route-table-public-1"
  }
}

resource "aws_route_table_association" "troute_table_accociate_2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.route_table_2_public.id
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.autoscalling_vpc.id
  cidr_block        = lookup(var.cidr_ranges, "private1")
  availability_zone = var.availability_zones.zone_a
  tags = {
    Name = "private-subnet-1"
  }
}

resource "aws_route_table" "route_nat_gateway_1" {
  vpc_id = aws_vpc.autoscalling_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway_autoscalling_1.id
  }
  tags = {
    Name = "route-table-nat-1"
  }
}
resource "aws_route_table_association" "route_table_accociate_3" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.route_nat_gateway_1.id
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id            = aws_vpc.autoscalling_vpc.id
  cidr_block        = lookup(var.cidr_ranges, "private2")
  availability_zone = var.availability_zones.zone_b
  tags = {
    Name = "private-subnet-2"
  }
}

resource "aws_route_table" "route_nat_gateway_2" {
  vpc_id = aws_vpc.autoscalling_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway_autoscalling_2.id
  }
  tags = {
    Name = "route-table-nat-1"
  }
}
resource "aws_route_table_association" "route_table_accociate_4" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.route_nat_gateway_2.id
}

resource "aws_internet_gateway" "autoscalling_gateway" {
  vpc_id = aws_vpc.autoscalling_vpc.id
}

resource "aws_eip" "eip_1" {
  domain = "vpc"
}

resource "aws_eip" "eip_2" {
  domain = "vpc"
}


resource "aws_nat_gateway" "nat_gateway_autoscalling_1" {
  allocation_id = aws_eip.eip_1.id
  subnet_id     = aws_subnet.public_subnet_1.id

  tags = {
    Name = "nat-gateway-1"
  }
}

resource "aws_nat_gateway" "nat_gateway_autoscalling_2" {
  allocation_id = aws_eip.eip_2.id
  subnet_id     = aws_subnet.public_subnet_2.id
  tags = {
    Name = "nat-gateway-1"
  }
}














