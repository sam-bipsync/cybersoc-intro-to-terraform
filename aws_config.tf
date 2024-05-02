# This file sets up both our Terraform state, and our providers & plugins.
terraform {
  # Your Terraform state is being stored in a S3 Bucket that already exists. 
  # We tell it the bucket name and where in the bucket to store you state file
  backend "s3" {
    bucket = "terraform20240430145658716700000001"
    key    = "students/$YOUR_FIRST_AND_LAST_NAME$/terraform.tf" # TODO Add your first name initial and full last name here, like so: students/jsmith/terraform.tf
    region = "us-east-1"
    dynamodb_table = "terraform-state-lock"
  }
}

# We are only using one provider, AWS, and have included a region config for that provider. 
# If we used multiple cloud providers then we would also have their plugins and config here.
provider "aws" {
  region = "us-east-1"
}