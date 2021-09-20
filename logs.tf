resource "aws_cloudwatch_log_group" "main" {
  name              = "/ecs/${var.app_name}"
  retention_in_days = 1

  tags = {
    Name = var.app_name
  }
}