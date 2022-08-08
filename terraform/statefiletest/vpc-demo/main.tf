provider "aws" {

  region  = "us-east-2"

}



terraform {

  backend "s3" {

    bucket = "mystiqueaura"

    key    = "terraform/terraform.tfstate"

    region = "us-east-2"

  }

}



resource "aws_vpc" "main" {

  cidr_block       = "10.0.0.0/16"

  instance_tenancy = "default"



  tags = {

    Name = "demo"

  }

}