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
  region = var.region
}

resource "random_id" "myrand_id" {
  byte_length = 7
}
//bucket creation
resource "aws_s3_bucket" "mywebapp-bucket" {
    bucket = "webapp-bucket-${random_id.myrand_id.hex}" 

}
// allowing public access

resource "aws_s3_bucket_public_access_block" "webbapp-acl" {
  bucket = aws_s3_bucket.mywebapp-bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

// definigng policy

resource "aws_s3_bucket_policy" "webapp-poliy" {
  bucket = aws_s3_bucket.mywebapp-bucket.id
  policy = jsonencode( 
    {
    Version = "2012-10-17",
    Statement = [
        {
            Sid = "PublicReadGetObject",
            Effect = "Allow",
            Principal = "*",
            Action = "s3:GetObject",
            Resource ="arn:aws:s3:::${aws_s3_bucket.mywebapp-bucket.id}/*"
            
        }
                ]
    }
  )
}
//aws_s3_bucket_website_configuration 

resource "aws_s3_bucket_website_configuration" "webbapp-website-config" {
  bucket = aws_s3_bucket.mywebapp-bucket.id

  index_document {
    suffix = "index.html"
  }
}

//uploading files
resource "aws_s3_object" "indexfile" {
    bucket = aws_s3_bucket.mywebapp-bucket.bucket
    source = "./index.html"
    key = "index.html"
    content_type = "text/html"
}
resource "aws_s3_object" "stylefile" {
    bucket = aws_s3_bucket.mywebapp-bucket.bucket
    source = "./style.css"
    key = "style.css"  
    content_type = "text/css"
}