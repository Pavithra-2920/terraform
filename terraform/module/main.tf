provider "aws" {
    region = "us-east-2"
    access_key = "AKIARSZ2H74MVNWAR6TY"
    secret_key = "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"

}
module "Vpc-mod" {
    source = "./vpc"
}

module "EC2-mod" {
    source = "./EC2-mod"
}

