provider "aws" {
    region = "us-east-1"
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