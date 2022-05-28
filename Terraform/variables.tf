variable "aws-access-key" {
  type = string
}

variable "aws-secret-key" {
  type = string
}

variable "aws-region" {
  type = string
}
variable "ami-id" {
  type = string
}

variable "iam-instance-profile" {
  default = ""
  type = string
}

variable "instance-type" {
  type = string
}

variable "name" {
  type = string
}


variable "network-interface-id" {
  type = string
}

variable "device-index" {
  type = number
}

variable "repository-url" {
  type = string
}
