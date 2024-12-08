output "bucket_name" {
  value = aws_s3_bucket.mywebapp-bucket.bucket
}
output "bucket_id" {
  value = aws_s3_bucket.mywebapp-bucket.id
}
output "website_URL" {
  value = aws_s3_bucket_website_configuration.webbapp-website-config.website_endpoint
}