# Creating VPC

resource "aws_vpc" "my-vpc" {
    cidr_block = "10.0.0.0/16"

    tags = {
      Name = "my-vpc"
    } 
}
# Creating subnets
resource "aws_subnet" "private-subnet" {
  vpc_id = aws_vpc.my-vpc.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "private-subnet"
  }
}
resource "aws_subnet" "public-subnet" {
    vpc_id = aws_vpc.my-vpc.id
    cidr_block = "10.0.2.0/24"
    tags = {
      Name = "public-subnet"
    }
  
}
# Creating Internet gatway
resource "aws_internet_gateway" "my-igw-tf" {
    vpc_id = aws_vpc.my-vpc.id
    tags = {
      Name = "my-igw-tf"
    }
  
}
# Creating Route table
resource "aws_route_table" "my-route-table" {
  vpc_id = aws_vpc.my-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-igw-tf.id
  }
    tags = {
      Name = "my-route-table"
    }
}

resource "aws_route_table_association" "my-associat" {
    route_table_id = aws_route_table.my-route-table.id
    subnet_id = aws_subnet.public-subnet.id

}