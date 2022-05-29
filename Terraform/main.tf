resource "aws_instance" "webapp" {
  ami = var.ami-id
  iam_instance_profile = var.iam-instance-profile
  instance_type = var.instance-type

  user_data = templatefile("${path.module}/user_data.sh", {repository_url = var.repository-url})

  tags = {
    Name = var.name
  }
}