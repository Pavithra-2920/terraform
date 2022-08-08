provider "aws" {
  region = "us-east-1"
}
resource "aws_instance" "linux" {
  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = "n.v_key"
  
  tags = {
  Name = "cosmic_instance"
  region= "ue1"
  environment= "prod"
    }
}
output "instance_output_is_here" {
  value = aws_instance.linux
}



