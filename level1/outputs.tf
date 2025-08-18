output "instance_hostname" {
  description = "private dns name of the instance"
  value       = aws_instance.app_server.private_dns
}

output "instance_ip" {
  description = "public ip of the instance"
  value       = aws_instance.app_server.public_ip
}
