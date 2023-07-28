# Creating VPC
resource "aws_vpc" "three-tier-app-vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  tags = {
    Name = var.app
  }
}

# Creating 1st web subnet 
resource "aws_subnet" "public-subnet-1" {
  vpc_id                  = aws_vpc.three-tier-app-vpc.id
  cidr_block             = "${var.subnet1_cidr}"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1a"
tags = {
    Name = "Web Subnet 1"
  }
}
# Creating 2nd web subnet 
resource "aws_subnet" "public-subnet-2" {
  vpc_id                  = aws_vpc.three-tier-app-vpc.id
  cidr_block             = var.subnet2_cidr
  map_public_ip_on_launch = true
  availability_zone = "us-east-1b"
tags = {
    Name = "Web Subnet 2"
  }
}
# Creating 1st application subnet 
resource "aws_subnet" "application-subnet-1" {
  vpc_id                  = aws_vpc.three-tier-app-vpc.id
  cidr_block             = var.subnet3_cidr
  map_public_ip_on_launch = false
  availability_zone = "us-east-1a"
tags = {
    Name = "Application Subnet 1"
  }
}
# Creating 2nd application subnet 
resource "aws_subnet" "application-subnet-2" {
  vpc_id                  = aws_vpc.three-tier-app-vpc.id
  cidr_block             = var.subnet4_cidr
  map_public_ip_on_launch = false
  availability_zone = "us-east-1b"
tags = {
    Name = "Application Subnet 2"
  }
}
# Create Database 1st Private Subnet
resource "aws_subnet" "database-subnet-1" {
  vpc_id            = aws_vpc.three-tier-app-vpc.id
  cidr_block        = var.subnet5_cidr
  availability_zone = "us-east-1a"
tags = {
    Name = "Database Subnet 1"
  }
}
# Create Database 2nd Private Subnet
resource "aws_subnet" "database-subnet-2" {
  vpc_id            = aws_vpc.three-tier-app-vpc.id
  cidr_block        = var.subnet6_cidr
  availability_zone = "us-east-1b"
tags = {
    Name = "Database Subnet 2"
  }
}

# Creating Internet Gateway 
resource "aws_internet_gateway" "app-igw" {
  vpc_id = aws_vpc.three-tier-app-vpc.id
}

# Creating Route Table
resource "aws_route_table" "app-route-table" {
  vpc_id = aws_vpc.three-tier-app-vpc.id
route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.app-igw.id
  }
tags = {
      Name = "Route to internet for app"
  }
}
# Associating Route Table
resource "aws_route_table_association" "rt1" {
  subnet_id = aws_subnet.public-subnet-1.id
  route_table_id = aws_route_table.app-route-table.id
}
# Associating Route Table
resource "aws_route_table_association" "rt2" {
  subnet_id = aws_subnet.public-subnet-2.id
  route_table_id = aws_route_table.app-route-table.id
}