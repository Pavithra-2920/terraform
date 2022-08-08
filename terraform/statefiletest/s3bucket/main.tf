provider "aws" {

    region = "us-east-2"

 

}

resource "aws_s3_bucket" "my-s3name" {

    bucket = "mystiqueaura"

    acl = "private"
    force_destroy = "true"



    tags = {

      Name = "coreservices"

      Environment = "prod"

      region = "useast2"

      managed = "terraform"

    }

}
output "bucket_id" {
    value = aws_s3_bucket.my-s3name.id
  
}