variable "aws_profile" {
  description = "The AWS profile specified within ~/.aws/credentials"
  default     = "iac_hello_world"
}

variable "aws_region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "az_count" {
  description = "Flexible az count when multi-az isnt priority"
  default     = "2"
}

variable "app_image" {
  description = "Docker image"
  default     = "alexwhen/docker-2048:latest"
}

variable "app_name" {
  description = "App name"
  default     = "trufan"
}

variable "app_port" {
  description = "App port"
  default     = 80
}

variable "health_check_path" {
  default = "/"
}

variable "fargate_cpu" {
  description = "Fargate instance CPU"
  default     = "256"
}

variable "fargate_memory" {
  description = "Fargate instance memory"
  default     = "512"
}