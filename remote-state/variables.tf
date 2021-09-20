variable "aws_profile" {
  description = "The AWS profile specified within ~/.aws/credentials"
  default     = "iac_hello_world"
}

variable "aws_region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "app_name" {
  description = "App name"
  default     = "trufan"
}