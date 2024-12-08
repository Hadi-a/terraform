output "Instance_IP" {
    value = aws_instance.nginx-server.public_ip  
}
output "URL" {
    value = "http://${aws_instance.nginx-server.public_ip}"
  
}