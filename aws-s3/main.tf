terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.80.0"
    }
    random = {
      source = "hashicorp/random"
      version = "3.6.3"
    }
  }
}
provider "aws" {
  region = "eu-north-1"
}

resource "random_id" "my_random_id" {
    byte_length = 7
 }

resource "aws_s3_bucket" "demo-bucket" {
    bucket = "demo-doumh-${random_id.my_random_id.hex}"
  }
resource "aws_s3_object" "myfiles" {
    bucket = aws_s3_bucket.demo-bucket.bucket
    source = "./myfile.txt"
    key = "mydata.txt"  
}

output "name" {
  value = random_id.my_random_id.hex
}