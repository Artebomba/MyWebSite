module "application-server" {
  source = ".."

  ami-id = "ami-015c25ad8763b2f11" # AMI for an Ubuntu Server for  region: eu-central-1

  iam-instance-profile = aws_iam_instance_profile.simple-web-app.id
  name = "Simple Web App"
  device-index = 0
  network-interface-id = aws_network_interface.simple-web-app.id
  repository-url = "repo URL"
  instance-type = "t2.micro"
}