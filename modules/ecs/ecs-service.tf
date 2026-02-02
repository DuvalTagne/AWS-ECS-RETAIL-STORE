resource "aws_ecs_service" "ecs_service_retail" {
  name            = "${var.app-name}-service-ui"
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.task_def.arn
  desired_count   = 2
  launch_type = "FARGATE"
  

  load_balancer {
    target_group_arn = var.lb_target_group_arn
    container_name   = "application"
    container_port   = 8080
  }
    network_configuration {
      assign_public_ip = true
      security_groups = var.security_group
      subnets = var.subnet
    }
}