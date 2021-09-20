terraform {
  backend "s3" {
    bucket  = "laino-tfstate"  # referencing ./remote-state
    key     = "dev/main.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}