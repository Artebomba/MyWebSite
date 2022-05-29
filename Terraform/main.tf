resource "aws_instance" "webapp" {
  ami = var.ami-id
  iam_instance_profile = var.iam-instance-profile
  instance_type = var.instance-type
  network_interface {
    device_index = var.device-index
    network_interface_id = aws_network_interface.simple-web-app.id
  }

  user_data = templatefile("${path.module}/user_data.sh", {repository_url = var.repository-url})

  tags = {
    Name = var.name
  }
}