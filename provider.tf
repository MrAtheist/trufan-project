provider "aws" {
  shared_credentials_file = "~/.aws/credentials"
  profile = var.aws_profile
  region = var.aws_region
}