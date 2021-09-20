data "aws_availability_zones" "available" {
}

resource "aws_vpc" "main" {
  cidr_block = "10.10.0.0/16"
}

# ${var.az_count} private subnets per az
resource "aws_subnet" "private" {
  count             = var.az_count
  cidr_block        = cidrsubnet(aws_vpc.main.cidr_block, 8, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  vpc_id            = aws_vpc.main.id

  tags = {
    Name = "${var.app_name}-private-${data.aws_availability_zones.available.names[count.index]}"
  }
}

# ${var.az_count} public subnets per az
resource "aws_subnet" "public" {
  count                   = var.az_count
  cidr_block              = cidrsubnet(aws_vpc.main.cidr_block, 8, var.az_count + count.index)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  vpc_id                  = aws_vpc.main.id
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.app_name}-public-${data.aws_availability_zones.available.names[count.index]}"
  }
}

# igw for public subnet
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = var.app_name
  }
}

# Route the public subnet traffic through igw
resource "aws_route" "internet_access" {
  route_table_id         = aws_vpc.main.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
}

# ${var.az_count} eip for natgw per az
resource "aws_eip" "main" {
  count      = var.az_count
  vpc        = true
  depends_on = [aws_internet_gateway.main]

  tags = {
    Name = "${var.app_name}-eip-${data.aws_availability_zones.available.names[count.index]}"
  }
}

# ${var.az_count} natgw per az
resource "aws_nat_gateway" "main" {
  count         = var.az_count
  subnet_id     = element(aws_subnet.public.*.id, count.index)
  allocation_id = element(aws_eip.main.*.id, count.index)

  tags = {
    Name = "${var.app_name}-natgw-${data.aws_availability_zones.available.names[count.index]}"
  }
}

# ${var.az_count} route table per az, route via natgw
resource "aws_route_table" "private" {
  count  = var.az_count
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = element(aws_nat_gateway.main.*.id, count.index)
  }

  tags = {
    Name = "${var.app_name}-private-${data.aws_availability_zones.available.names[count.index]}"
  }
}

resource "aws_route_table_association" "private" {
  count          = var.az_count
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = element(aws_route_table.private.*.id, count.index)
}

