# the allocated public IP
output "webserver_ip" {
  value = aws_instance.webserver.public_ip
}

# the allocated public DNS
output "webserver_dns" {
  value = aws_instance.webserver.public_dns
}

