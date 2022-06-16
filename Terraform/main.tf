resource "aws_instance" "webapp" {
  ami = lookup(var.ami-id, "eu-central-1", "ami-015c25ad8763b2f11" )
  iam_instance_profile = var.iam-instance-profile
  instance_type = var.instance-type
  network_interface {
    device_index = var.device-index
    network_interface_id = aws_network_interface.simple-web-app.id
  }

  user_data = templatefile("${path.module}/user_data.sh", {artem = "best"})

  tags = local.common_tags
  provider = aws.aws-frankfurt
  #key_name =aws_key_pair.generated_key.key_name
  key_name = data.aws_key_pair.my_main_aws_key_pair.key_name
}

locals {
    common_tags = {
        Name = var.name
        Project = "My web page"
    }
}
