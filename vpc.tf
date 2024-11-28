
# Create VPC
resource "aws_vpc" "secure" {
  cidr_block           = "10.0.0.0/16" # VPC CIDR block
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "vpc-public-mumbai"
  }
}

# Create a Public Subnet
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.secure.id
  cidr_block              = "10.0.1.0/24" # Subnet CIDR block
  map_public_ip_on_launch = true
  availability_zone       = "ap-south-1a" # Mumbai AZ
  tags = {
    Name = "public-subnet-mumbai"
  }
}

# Create an Internet Gateway
resource "aws_internet_gateway" "secure" {
  vpc_id = aws_vpc.secure.id
  tags = {
    Name = "vpc-public-igw-mumbai"
  }
}

# Create a Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.secure.id
  tags = {
    Name = "public-route-table-mumbai"
  }
}

# Add a Default Route to the Internet Gateway
resource "aws_route" "default" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0" # Default route for all traffic
  gateway_id             = aws_internet_gateway.secure.id
}

# Associate Route Table with Public Subnet
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}