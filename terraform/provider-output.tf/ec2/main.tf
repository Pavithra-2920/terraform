resource "aws_instance" "cosmic" {
   ami = var.ami_id
   instance_type = var.instance_type
   key_name = var.key_name
    tags = {
      Name = "Ec2"
  }

}
output "Instance-ip" {
   value = aws_instance.cosmic
}