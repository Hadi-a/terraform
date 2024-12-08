terraform { //block for terraform
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.78.0"
    }
  }
}

provider "aws" {
  region = var.region
}

resource "aws_instance" "myserver" {
    ami = "ami-08eb150f611ca277f"
    instance_type = "t3.micro"
  tags = {
    Name = "Sampleserver"
  }
}