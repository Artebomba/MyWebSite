resource "aws_iam_instance_profile" "simple-web-app" {
  name = "simple-web-app"
  role = aws_iam_role.simple-web-app.name
}

resource "aws_iam_role" "simple-web-app" {
  name = "simple-web-app"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}