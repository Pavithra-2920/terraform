provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "ec2_example" {

    ami           = "ami-090fa75af13c156b4"
    instance_type =  var.instance_type
    count = var.instance_count
    associate_public_ip_address = var.enable_public_ip
    tags = var.project_environment

}

resource "aws_iam_user" "example" {
  count = length(var.user_names)
  name  = var.user_names[count.index]
}

