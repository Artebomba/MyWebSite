terraform {
  backend "s3" {
    bucket = "artebomba.s3"
    key    = "remote.tfstate"
    region = "eu-central-1"
  }