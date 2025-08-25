output "instance_hostname" {
  description = "private dns name of the instance"
  value       = aws_instance.app_server.private_dns
}

output "instance_ip" {
  description = "public ip of the instance"
  value       = aws_instance.app_server.public_ip
}

output "private_key" {
  value	    = tls_private_key.example.private_key_pem
  sensitive = true
}

output "api_base_url" {
  value = "http://${aws_instance.app_server.public_ip}"
}
