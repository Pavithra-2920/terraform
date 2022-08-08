provider "aws" {
  region = "us-east-1"
}
 
 resource "aws_vpc" "testing" {
    cidr_block = var.cidr_block
    instance_tenancy = "default"

  tags = {
    Name = "testing"
    region = "uw1"
    environment = "prod"
    managed_by = "terraform"
  }
}
output "vpc_output" {
    value = aws_vpc.testing
}
