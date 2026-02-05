resource "aws_ecs_capacity_provider" "this" {
  count=var.managed_instances==0?0:1
  name    = "${var.app-name}-managed-instances-cp"
cluster = aws_ecs_cluster.cluster.name
  managed_instances_provider {
    infrastructure_role_arn = var.infrastructure_role_arn

    instance_launch_template {
      ec2_instance_profile_arn = aws_iam_instance_profile.ecs_instance_managed[count.index].arn

      network_configuration {
        subnets         = var.subnet
        security_groups = var.security_group
      }

      storage_configuration {
        storage_size_gib = 100
      }
    }
  }
}

resource "aws_iam_instance_profile" "ecs_instance_managed" {
  count=var.managed_instances==0?0:1
  name="${var.ec2_instance_profile_role_name}Profile"
  role=var.ec2_instance_profile_role_name
}



resource "aws_ecs_cluster_capacity_providers" "this" {
  count=var.managed_instances==0?0:1
  cluster_name = aws_ecs_cluster.cluster.name

  capacity_providers = var.requires_compatibilities != "FARGATE" ? [aws_ecs_capacity_provider.this[0].name] : ["FARGATE"]

  default_capacity_provider_strategy {
    base              = 2
    weight            = 1
    capacity_provider = var.requires_compatibilities != "FARGATE" ? aws_ecs_capacity_provider.this[0].name : "FARGATE"
  }
}