terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.AWSRegion
}

# Create a VPC
resource "aws_vpc" "databricks_vpc" {
  cidr_block = "10.52.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = { 
    Key:"Databricks"
    Value:"VPC"
  }
}

# Internet gateway
 resource "aws_internet_gateway" "databricks_igw"{
    vpc_id = aws_vpc.databricks_vpc.id
    tags = { 
    Key:"Databricks"
    Value:"igw"
    }
 }

#... attached to the VPC
resource "aws_internet_gateway_attachment" "databricks_igw_attachment" {
  internet_gateway_id = aws_internet_gateway.databricks_igw.id
  vpc_id              = aws_vpc.databricks_vpc.id
}

# The subnet for the NAT Gateway
resource "aws_subnet" "databricks_subnet_for_nat" {
  vpc_id     = aws_vpc.databricks_vpc.id
  cidr_block = "10.52.0.0/24"
  availability_zone  = "ap-east-1a"
  map_public_ip_on_launch  = true
  tags = {
    Key = "Databricks"
    Value = "subnet_for_nat"
  }
}

# The subnets for the VPC Endpoints
resource "aws_subnet" "databricks_subnet_public1" {
  vpc_id     = aws_vpc.databricks_vpc.id
  cidr_block = "10.52.6.0/24"
  availability_zone  = "ap-east-1a"
  map_public_ip_on_launch  = true
  tags = {
    Key = "Databricks"
    Value = "subnet_public1"
  }
}
resource "aws_subnet" "databricks_subnet_public2" {
  vpc_id     = aws_vpc.databricks_vpc.id
  cidr_block = "10.52.7.0/24"
  availability_zone  = "ap-east-1b"
  map_public_ip_on_launch  = true
  tags = {
    Key = "Databricks"
    Value = "subnet_public2"
  }
}
resource "aws_subnet" "databricks_subnet_public3" {
  vpc_id     = aws_vpc.databricks_vpc.id
  cidr_block = "10.52.8.0/24"
  availability_zone  = "ap-east-1c"
  map_public_ip_on_launch  = true
  tags = {
    Key = "Databricks"
    Value = "subnet_public3"
  }
}
# The private subnets for the Databricks clusters
resource "aws_subnet" "databricks_subnet_private1" {
  vpc_id     = aws_vpc.databricks_vpc.id
  cidr_block = "10.52.160.0/19"
  availability_zone  = "ap-east-1a"
  map_public_ip_on_launch  = false
  tags = {
    Key = "Databricks"
    Value = "subnet_private1"
  }
}
resource "aws_subnet" "databricks_subnet_private2" {
  vpc_id     = aws_vpc.databricks_vpc.id
  cidr_block = "10.52.192.0/19"
  availability_zone  = "ap-east-1b"
  map_public_ip_on_launch  = false
  tags = {
    Key = "Databricks"
    Value = "subnet_private2"
  }
}
resource "aws_subnet" "databricks_subnet_private3" {
  vpc_id     = aws_vpc.databricks_vpc.id
  cidr_block = "10.52.224.0/19"
  availability_zone  = "ap-east-1c"
  map_public_ip_on_launch  = false
  tags = {
    Key = "Databricks"
    Value = "subnet_private3"
  }
}
# The Elastic IP for the NAT Gateway
resource "aws_eip" "databricks_eip"{
    tags = {
        Key = "Databricks"
        Value = "subnet_private3"
  }
}

# The NAT gateway
resource "aws_nat_gateway" "databricks_nat_gateway" {
  allocation_id = aws_eip.databricks_eip.id
  connectivity_type = "public"
  subnet_id     = aws_subnet.databricks_subnet_for_nat.id
  tags = {
        Key = "Databricks"
        Value = "nat_gateway"
  }
}
# The route table attached to the nat subnet
resource "aws_route_table" "databricks_nat_route_table" {
  vpc_id = aws_vpc.databricks_vpc.id
  tags = {
        Key = "Databricks"
        Value = "nat_route_table"
  }
 
}
# Routes to the internet
resource "aws_route" "databricks_route_to_internet" {
  depends_on = [aws_internet_gateway_attachment.databricks_igw_attachment]
  route_table_id = aws_route_table.databricks_nat_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.databricks_igw.id
 
}
 # Associate the route table to the subnet
 resource "aws_route_table_association" "databricks_route_to_subnet" {
  depends_on =  [aws_route.databricks_route_to_internet]
  subnet_id      = aws_subnet.databricks_subnet_for_nat.id
  route_table_id = aws_route_table.databricks_nat_route_table.id
}
 # The route table for the private subnets
 resource "aws_route_table" "databricks_private_route_table" {
  vpc_id = aws_vpc.databricks_vpc.id
  tags = {
        Key = "Databricks"
        Value = "private_route_table"
  }
 }
resource "aws_route" "databricks_route_to_internet_In_Private_Route_Table" {
  route_table_id = aws_route_table.databricks_private_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.databricks_nat_gateway.id
  }
resource "aws_route_table_association" "databricks_route_to_PrivateSubnet1" {
  depends_on =  [aws_route.databricks_route_to_internet_In_Private_Route_Table]
  subnet_id      = aws_subnet.databricks_subnet_private1.id
  route_table_id = aws_route_table.databricks_private_route_table.id
}
resource "aws_route_table_association" "databricks_route_to_PrivateSubnet2" {
  depends_on =  [aws_route.databricks_route_to_internet_In_Private_Route_Table]
  subnet_id      = aws_subnet.databricks_subnet_private2.id
  route_table_id = aws_route_table.databricks_private_route_table.id
}
resource "aws_route_table_association" "databricks_route_to_PrivateSubnet3" {
  depends_on =  [aws_route.databricks_route_to_internet_In_Private_Route_Table]
  subnet_id      = aws_subnet.databricks_subnet_private3.id
  route_table_id = aws_route_table.databricks_private_route_table.id
}
# The S3 gateway endpoint