provider "aws" {
    region = "us-east-1"
    access_key = "AKIARSZ2H74MVNWAR6TY"
    secret_key = "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"

}
resource "aws_subnet" "demo_public_subnet" {
  vpc_id                  = "vpc-0aa6082ca42ffebc7"
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    Name        = "demo_sub_public"
  }
}
output "public_subnetid" {
  value = aws_subnet.demo_public_subnet.id
}

resource "aws_subnet" "demo_private_subnet" {
  vpc_id                  = "vpc-0aa6082ca42ffebc7"
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1c"
  map_public_ip_on_launch = true
  tags = {
    Name        = "demo_sub_private"
  } 
}
output "private_subnetid" {
  value = aws_subnet.demo_private_subnet.id
}
