variable "app-name" {
  default = "retail-store"
}

variable "lb_target_group_arn" {
}
variable "subnet" {
  default = ["subnet-0d87b5bd28042168e","subnet-044d0acc4cb47ac95"]
}
variable "security_group" {
}

variable "definition" {
  default = "modules/ecs/task-definition.json"
}
variable "network_mode" {
  default = "awsvpc"
}

variable "requires_compatibilities" {
  default = "FARGATE"
}

variable "ec2_instance_profile_arn" {
}

variable "infrastructure_role_arn" {
  
}

variable "managed_instances" {
  default = 0
}