provider "aws" {
  shared_credentials_file = "~/.aws/credentials"
  profile = var.aws_profile
  region = var.aws_region
}

resource "aws_s3_bucket" "tfstate" {
  bucket = "${var.app_name}-tfstate"
  force_destroy = true

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = false # ideally this should set to true
  }
}

resource "aws_dynamodb_table" "tfstate_lock" {
  name           = "${var.app_name}-tfstate"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}