output "instance-id" {
  value = aws_instance.webapp.id
}

output "name" {
  value = var.name
}

output "private-ip" {
  value = aws_instance.webapp.private_ip
}

output "public-ip" {
  value = aws_instance.webapp.public_ip
}