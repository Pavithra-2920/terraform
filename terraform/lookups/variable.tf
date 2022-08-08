variable "aws_region" {
  default="ap-southeast-1"
}

variable "aws_amis" {
  default ={
    "ap-southeast-1" = "ami-0ff89c4ce7de192ea"
    "us-east-1" = "ami-090fa75af13c156b4"
  }
  
}

variable "app_name" {
  default = "local_test2"
}