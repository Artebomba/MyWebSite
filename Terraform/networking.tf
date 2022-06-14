resource "aws_vpc" "simple-web-app" {
  cidr_block = "10.0.0.0/16" // completely private 10.0 are fixed
  enable_dns_hostnames = true

  tags = {
    Name = "Simple Web App VPC"
  }
}

resource "aws_internet_gateway" "simple-web-app" {
  vpc_id = aws_vpc.simple-web-app.id
}

resource "aws_route_table" "allow-outgoing-access" {
  vpc_id = aws_vpc.simple-web-app.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.simple-web-app.id
  }

  tags = {
    Name = "Route Table Allowing Outgoing Access"
  }
}

resource "aws_subnet" "subnet-public-web-app" {
  cidr_block = "10.0.1.0/24"
  vpc_id = aws_vpc.simple-web-app.id
  availability_zone = "eu-central-1a"

  tags = {
    Name = "Simple Web App Subnet"
  }
}

resource "aws_route_table_association" "web-app-subnet" {
  subnet_id = aws_subnet.subnet-public-web-app.id
  route_table_id = aws_route_table.allow-outgoing-access.id
}

resource "aws_security_group" "allow-web-traffic" {
  name = "allow-web-traffic"
  description = "Allow HTTP inbound traffic"
  vpc_id = aws_vpc.simple-web-app.id

  ingress {
    description = "HTTP"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "allow-ssh-traffic" {
  name = "allow-ssh-traffic"
  description = "Allow SSH inbound traffic"
  vpc_id = aws_vpc.simple-web-app.id

  ingress {
    description = "SSH"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "allow-all-outbound" {
  name = "allow-all-outbound"
  description = "Allow all outbound traffic"
  vpc_id = aws_vpc.simple-web-app.id

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_network_interface" "simple-web-app" {
  subnet_id       = aws_subnet.subnet-public-web-app.id
  private_ips     = ["10.0.1.50"]
  security_groups = [
    aws_security_group.allow-all-outbound.id,
    aws_security_group.allow-ssh-traffic.id,
    aws_security_group.allow-web-traffic.id
  ]
}

resource "aws_eip" "simple-web-app" {
  vpc = true
  network_interface = aws_network_interface.simple-web-app.id
  associate_with_private_ip = "10.0.1.50"
  depends_on = [
    aws_internet_gateway.simple-web-app
  ]
  address = ""
}

#resource "tls_private_key" "my_key" {
#  algorithm = "RSA"
#  rsa_bits  = 4096
#}

#resource "aws_key_pair" "generated_key" {
#  key_name   = var.generated_key_name[0]
#  public_key = tls_private_key.my_key.public_key_openssh
#
#  provisioner "local-exec" {    # Generate "terraform-key-pair.pem" in current directory
#    command = <<-EOT
#      echo '${tls_private_key.my_key.private_key_pem}' > ./'${var.generated_key_name[0]}'.pem
#      chmod 400 ./'${var.generated_key_name[0]}'.pem
#    EOT
#  }
#}

data "aws_key_pair" "my_main_aws_key_pair" {
  key_pair_id = "key-0cd9e7de9bcf2772d"
  key_name = "artem-key-frankfurt"
}