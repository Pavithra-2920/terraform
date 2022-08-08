provider "aws" {
  region = "us-east-1"
}


resource "aws_instance" "prod" {
  ami           = var.ami1
  instance_type = var.instance_type
  key_name      = var.key_name
  count         = 1
}

resource "aws_instance" "dev" {
  ami           = var.ami2
  instance_type = var.instance_type
  key_name      = var.key_name
  count         = 1
}
