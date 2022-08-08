provider "aws" {
    region = "us-east-2"
    access_key = "AKIARSZ2H74MVNWAR6TY"
    secret_key = "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"

}
###################################################################################
resource "aws_vpc" "vpc" {
    cidr_block = "10.0.0.0/16"
    tags  = {
        name = "demovpc"
    }
}
output "vpc_id" {
    value = aws_vpc.vpc.id
  
} 
resource "aws_subnet" "demo_public_subnet" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-2b"
  map_public_ip_on_launch = true
  tags = {
    Name        = "demo_sub_public"
  }
}
output "public_subnetid" {
  value = aws_subnet.demo_public_subnet.id
}

resource "aws_subnet" "demo_private_subnet" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-2a"
  map_public_ip_on_launch = true
  tags = {
    Name        = "demo_sub_private"
  }
}
output "private_subnetid" {
  value = aws_subnet.demo_private_subnet.id
}


#Creating IGW and attaching for demo VPC 

resource "aws_internet_gateway" "demo_igw" {
    vpc_id = "${aws_vpc.vpc.id}"
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
    vpc_id = "${aws_vpc.vpc.id}"
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
    subnet_id = "${aws_subnet.demo_public_subnet.id}"
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
   subnet_id = "${aws_subnet.demo_public_subnet.id}"
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
    vpc_id = "${aws_vpc.vpc.id}"  
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
    subnet_id = "${aws_subnet.demo_private_subnet.id}"
    route_table_id = "${aws_route_table.demo_private_rt.id}"
}