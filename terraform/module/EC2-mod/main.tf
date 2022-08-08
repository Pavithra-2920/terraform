provider "aws" {
    region = "us-east-2"
    access_key = "AKIARSZ2H74MVNWAR6TY"
    secret_key = "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"

}
 #Create the Security Group
resource "aws_security_group" "ssh_Sg_id" {
 vpc_id  = "vpc-0bb4647f032ebdc6e"
 name    = "My VPC SG"
 description = "My VPC Security Group"
 # allow ingress of port 22
 ingress {
    from_port = 22
      to_port = 22
      protocol = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    } 
 # allow egress of all ports  
  egress {
    from_port = 0
        to_port  = 0
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }
 tags = {
Name = "RDP"
Description = "Allow RPD" }
}
output "security_group_id" {
 value = aws_security_group.ssh_Sg_id.id
}


resource "aws_instance" "linux" {
    ami =   "ami-0960ab670c8bb45f3"
    instance_type = "t2.micro"
    key_name = "key-ohio"
    associate_public_ip_address = "true"
    vpc_security_group_ids = [aws_security_group.ssh_Sg_id.id]
    subnet_id = "subnet-01d84368c528c51a2"
 
        tags = {
            Name = "application"
 }
}
output "Application_IP" {
  value = aws_instance.linux.id
}


