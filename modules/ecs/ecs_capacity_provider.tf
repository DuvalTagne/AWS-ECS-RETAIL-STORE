resource "aws_ecs_capacity_provider" "this" {
  count=var.instances==0?0:1
  name    = "${var.app-name}-managed-instances-cp"
cluster = aws_ecs_cluster.cluster.name

 dynamic "managed_instances_provider" {
  for_each = var.requires_compatibilities=="MANAGED_INSTANCES"?[1]:[]
  content {
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

   dynamic "auto_scaling_group_provider" {
  for_each = var.requires_compatibilities=="EC2"?[1]:[]
  content {
    auto_scaling_group_arn = aws_autoscaling_group.this[0].arn
    managed_termination_protection = "ENABLED"
    managed_scaling {
      status = "ENABLED"
    }
  }
 
  }
}

resource "aws_autoscaling_group" "this" {
  count=var.requires_compatibilities=="EC2"?1:0
  min_size = 1
  max_size = 3
  launch_template {
    id=aws_launch_template.this[0].id
  }
}
resource "aws_launch_template" "this" {
   count=var.requires_compatibilities=="EC2"?1:0
  name_prefix = "ec2-retail-store-launch-template"
  image_id = "ami-096f46d460613bed4"
  instance_type = "t3.micro"
  network_interfaces {
    associate_public_ip_address = true
    security_groups = var.security_group
  }
}
resource "aws_iam_instance_profile" "ecs_instance_managed" {
  count=var.instances==0?0:1
  name="${var.ec2_instance_profile_role_name}Profile"
  role=var.ec2_instance_profile_role_name
}



resource "aws_ecs_cluster_capacity_providers" "this" {
  count=var.instances==0 && var.requires_compatibilities=="MANAGED_INSTANCES"?0:1
  cluster_name = aws_ecs_cluster.cluster.name

  capacity_providers = var.requires_compatibilities != "FARGATE" ? [aws_ecs_capacity_provider.this[0].name] : ["FARGATE"]

  default_capacity_provider_strategy {
    base              = 2
    weight            = 1
    capacity_provider = var.requires_compatibilities != "FARGATE" ? aws_ecs_capacity_provider.this[0].name : "FARGATE"
  }
}