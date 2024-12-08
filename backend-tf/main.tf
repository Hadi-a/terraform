terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.80.0"
    }
  }
  backend "s3" {
    bucket = "demo-doumh-0c933011a905cb"
    key = "backend.tfstate"
    region = "eu-north-1"
    
  }
}

provider "aws" {
  region = "eu-north-1"
}

resource "aws_instance" "myinstance" {
    ami = "ami-08eb150f611ca277f"
    instance_type = "t3.micro"
    tags = {
      Name="test server"
    }  
}