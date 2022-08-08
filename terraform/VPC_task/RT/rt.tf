provider "aws" {
    region = "us-east-1"
    access_key = "AKIARSZ2H74MVNWAR6TY"
    secret_key = "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"

}
#Creating IGW and attaching for demo VPC 

resource "aws_internet_gateway" "demo_igw" {
    vpc_id = "vpc-0aa6082ca42ffebc7"
    tags = {
        Name = "demo-igw"
    }
}
output "internet_gateway_id" {
  value = aws_internet_gateway.demo_igw.id
}
#######################################################
#Adding Route table and IGW
resource "aws_route_table" "demo_public_rt" {
    vpc_id = "vpc-0aa6082ca42ffebc7"
    route {
        //associated subnet can reach everywhere
        cidr_block = "0.0.0.0/0"         //CRT uses this IGW to reach internet
        gateway_id = "${aws_internet_gateway.demo_igw.id}" 
    }
    tags = {
        Name = "demo-public-rt"
    }
}
output "demo_Public_RT_id" {
  value = aws_route_table.demo_public_rt.id
}
#######################################################
#Adding public subnet to public route table
resource "aws_route_table_association" "demo-public-routetable"{
    subnet_id = "subnet-074353c18f4b7af3c"
    route_table_id = "${aws_route_table.demo_public_rt.id}"
}
#######################################################
#Creating an EIP
resource "aws_eip" "demo_nat_eip" {
  vpc = true
  tags = {
      Name = "demo_nat_eip"
  }
}
output "demo_nat_eip" {
  value = aws_eip.demo_nat_eip.id
}
###################################################################
#Creating NatGateway for Production VPC
resource "aws_nat_gateway" "demo_natgateway"{
   allocation_id= "${aws_eip.demo_nat_eip.id}"
   subnet_id = "subnet-074353c18f4b7af3c"
    tags = {
      Name = "demo Natgateway"
          }
}
output "demo_natgateway_id" {
  value = aws_nat_gateway.demo_natgateway.id
}
#######################################################################
#Adding Route table and NatGateway
resource "aws_route_table" "demo_private_rt" {
    vpc_id = "vpc-0aa6082ca42ffebc7"  
    route {
        //associated subnet can reach everywhere
        cidr_block = "0.0.0.0/0"         //CRT uses this IGW to reach internet
        gateway_id = "${aws_nat_gateway.demo_natgateway.id}" 
    }
    tags = {
        Name = "demo-private-rt"
    }
}
output "demo_Private_RT_id"{
    value = aws_route_table.demo_private_rt.id
}
#######################################################
#Adding private subnet to private route table
resource "aws_route_table_association" "demo-private-routetable"{
    subnet_id = "subnet-00e50a1d0b48ed761"
    route_table_id = "${aws_route_table.demo_private_rt.id}"
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~END~~~~~~~~~~~~~~~~~~~~~~~~~~~#


    
