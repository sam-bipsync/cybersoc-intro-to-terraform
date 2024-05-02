terraform {
  backend "s3" {
    bucket = "terraform20240430145658716700000001"
    key    = "students/YOUR_FIRST_AND_LAST_NAME/terraform.tf" # TODO Add your first name initial and full last name here, like so: students/jsmith/terraform.tf
    region = "us-east-1"
    dynamodb_table = "terraform-state-lock"
  }
}

provider "aws" {
  region = "us-east-1"
}