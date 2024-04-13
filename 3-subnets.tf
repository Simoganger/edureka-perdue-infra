resource "aws_subnet" "private_us_east_2a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.0.0/19"
  availability_zone = var.zone_1

  tags = {
    "Name"                            = "private-us-east-2a"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/devl"      = "owned"
  }
}

resource "aws_subnet" "private_us_east_2b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.32.0/19"
  availability_zone = var.zone_2

  tags = {
    "Name"                            = "private-us-east-2b"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/devl"      = "owned"
  }
}

resource "aws_subnet" "public_us_east_2a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.64.0/19"
  availability_zone       = var.zone_1
  map_public_ip_on_launch = true

  tags = {
    "Name"                       = "public-us-east-2a"
    "kubernetes.io/role/elb"     = "1"
    "kubernetes.io/cluster/devl" = "owned"
  }
}

resource "aws_subnet" "public_us_east_2b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.96.0/19"
  availability_zone       = var.zone_2
  map_public_ip_on_launch = true

  tags = {
    "Name"                       = "public-us-east-2b"
    "kubernetes.io/role/elb"     = "1"
    "kubernetes.io/cluster/devl" = "owned"
  }
}
