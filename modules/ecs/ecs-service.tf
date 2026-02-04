resource "aws_ecs_service" "ecs_service_retail" {
  name            = "${var.app-name}-service-ui"
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.task_def.arn
  desired_count   = 2
  launch_type = var.requires_compatibilities=="FARGATE"?var.requires_compatibilities:"EC2"
  

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
dynamic "capacity_provider_strategy" {
    # Si var.type == "managed_instances", on crée une liste d'un élément pour activer le bloc
    # Sinon, on donne une liste vide [], et le bloc ne sera pas généré.
    for_each = var.requires_compatibilities=="MANAGED_INSTANCES" ? [1] : []

    content {
      capacity_provider = aws_ecs_capacity_provider.this[0].name
      weight            = 1
    }
  }
}