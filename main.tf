resource "aws_s3_bucket" "application_source" {
  bucket = "cybersoc-intro-terraform-applications"
}

resource "aws_s3_object" "application_source" {
  bucket = aws_s3_bucket.application_source.id
  key    = "application/default.zip"
  source = "default_app.zip"
}

resource "aws_elastic_beanstalk_application" "example_application" {
  name        = "example-nodejs-app"
  description = "Example NodeJS application deployed on AWS Elastic Beanstalk"
}

resource "aws_elastic_beanstalk_environment" "example_application" {
  name                = "prod"
  application         = aws_elastic_beanstalk_application.example_application.name
  solution_stack_name = "64bit Amazon Linux 2023 v6.1.4 running Node.js 20"

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = "aws-elasticbeanstalk-ec2-role"
  }
}

resource "aws_elastic_beanstalk_application_version" "example_application" {
  name        = "v1"
  application = "example-nodejs-app"
  description = "application version created by terraform"
  bucket      = aws_s3_bucket.application_source.id
  key         = aws_s3_object.application_source.id
}

output "endpoint" {
  value = aws_elastic_beanstalk_environment.example_application.endpoint_url
}