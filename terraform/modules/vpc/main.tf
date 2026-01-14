resource "aws_vpc" "this" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.environment}-vpc"
  }
}

resource "aws_subnet" "public" {
  count                   = 2
  vpc_id                  = aws_vpc.this.id
  cidr_block              = cidrsubnet(aws_vpc.this.cidr_block, 4, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.environment}-public-${count.index}"
  }
}

resource "aws_subnet" "private" {
  count     = 2
  vpc_id    = aws_vpc.this.id
  cidr_block = cidrsubnet(aws_vpc.this.cidr_block, 4, count.index + 2)
  tags = {
    Name = "${var.environment}-private-${count.index}"
  }
}

output "vpc_id" {
  value = aws_vpc.this.id
}

output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.private[*].id
}
