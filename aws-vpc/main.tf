terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.80.0"
    }
  }
}

provider "aws" {
  region = "eu-north-1"
}

# creating VPC
resource "aws_vpc" "my-vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "my-vpc-tf"
    } 
}

# Creating Private Subnet
resource "aws_subnet" "private-subnet" {
    cidr_block = "10.0.1.0/24"
    vpc_id = aws_vpc.my-vpc.id  
    tags = {
      Name = "my-private-subnet"
    }
}
# Creating Public Subnet
resource "aws_subnet" "public-subnet" {
    cidr_block = "10.0.2.0/24"
    vpc_id = aws_vpc.my-vpc.id  
    tags = {
      Name = "my-public-subnet"
    }
}
# Creating Internet gatway
resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.my-vpc.id
  tags = {
    Name = "my-igw-tf"
  }
}
# Route table
resource "aws_route_table" "my-route-table" {
  vpc_id = aws_vpc.my-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-igw.id
  }
   tags = {
    Name = "my-rt-tf"
  }
}

# Association of route table to subnet 
resource "aws_route_table_association" "pub-sub-associat" {
    route_table_id = aws_route_table.my-route-table.id
    subnet_id = aws_subnet.public-subnet.id
}
# Creating instance
resource "aws_instance" "myserver" {
    ami = "ami-08eb150f611ca277f"
    instance_type = "t3.micro"
    subnet_id = aws_subnet.public-subnet.id
  tags = {
    Name = "Sampleserver"
  }
}

output "ip" {
  value = aws_instance.myserver.private_ip
  }
