provider "aws" {
    region = "us-east-1"
    access_key = "AKIARSZ2H74MVNWAR6TY"
    secret_key = "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"

}

#Creating Security
resource "aws_security_group" "ssh_sg" {
  name = "SSH"
  description = "Allow SSH inbound traffic"
  vpc_id      = "vpc-0bb4647f032ebdc6e"
  ingress {
      from_port = 22
      to_port = 22
      protocol = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
      from_port = 0
      to_port = 0
      protocol = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
}
output "ssh_Sg_id" {
    value = aws_security_group.ssh_sg.id
}