resource "aws_ecs_task_definition" "task_def" {
  family = "${var.app-name}-ecs-ui"
  network_mode = var.network_mode
  requires_compatibilities = [ "${var.requires_compatibilities}" ]
  cpu = 1024
  memory = 2048
  runtime_platform {
    cpu_architecture = "X86_64"
    operating_system_family = "LINUX"
  }
  container_definitions = file(var.definition)
}