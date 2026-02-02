resource "aws_ecs_cluster" "cluster" {
  name = "${var.app-name}-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}