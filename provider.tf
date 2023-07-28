provider "aws"{
    region = "us-east-1" # AWS region code where you want your aws resources to be created
}
terraform {
  required_version = "> 1.0.0" # have required terraform version
  #following configuration is to store tfstate file in s3 bucket use it according to your need.
  /*backend "s3" {
    bucket = "my-terraform-state-bucket1" # AWS S3 bucket name where state file will be stored
    key    = "terraform-project/terraform.tfstate" # name of the state file
    dynamodb_table = "your-dynamodb-table-name"
  }*/
}