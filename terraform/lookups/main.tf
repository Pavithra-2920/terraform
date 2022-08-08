provider "aws" {
  region = "${var.aws_region}"
}


locals {
  name = "${var.app_name}-${var.aws_region}"
  department = "cloudez"
  managed-by = "terraform"
  team       = "CS"
  }
 
 resource "aws_instance" "demo_ec2" {   
    instance_type = "t2.micro"
    ami = "${lookup(var.aws_amis , var.aws_region)}"
    count = 1
    tags = {
       Name = local.name
    }
 }