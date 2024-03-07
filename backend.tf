# Purpose: This file is used to configure the backend for the terraform state file. 
# It sets up a remote backend that stores the state file in an S3 bucket.
terraform {
  backend "s3" {
    bucket = "neyo-capstone-remote-backend"
    region = "eu-west-2"
    key = "eks/terraform.tfstate"
  }
}



