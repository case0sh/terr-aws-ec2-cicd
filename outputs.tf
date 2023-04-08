# the allocated public IP
output "webserver_ip" {
  value = aws_instance.webserver.public_ip
}

# the allocated public DNS
output "webserver_dns" {
  value = aws_instance.webserver.public_dns
}

output "vm_linux_server_instance_public_ip" {
  value = aws_eip_association.linux-eip-association.public_ip
}

output "vm_linux_server_instance_private_ip" {
  value = aws_instance.webserver.private_ip
}