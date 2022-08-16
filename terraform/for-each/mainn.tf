provider "aws" {
  region = "us-east-1" 
}

variable "vpcs" {
  default = {
    cosmic = "10.0.0.0/16",   
    qwerty = "10.1.0.0/16"
  }
    }


resource "aws_vpc" "demo-vpc" {
    for_each = var.vpcs
    cidr_block = each.value
    tags = {
        "Name" = each.key
    }
  
}

