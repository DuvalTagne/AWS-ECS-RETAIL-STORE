module "lb"{
    source = "./modules/lb"
}

module "ecs" {
  source = "./modules/ecs"
  security_group = ["${module.lb.sg_id}"]
  lb_target_group_arn = module.lb.lb-tg-arn
  ec2_instance_profile_arn = module.iam-role-instance.role_arn
  infrastructure_role_arn = module.iam-role-infra.role_arn
  //requires_compatibilities = "MANAGED_INSTANCES"
}

module "iam-role-instance" {
  source="./modules/iamRole"
  role_name = "ecsInstanceRoleManagedInstance"
  policies_to_attach = [data.aws_iam_policy.instance-role-policy]
  assume_role_policy = data.aws_iam_policy_document.ecs_assume_role_policy.json
}

module "iam-role-infra" {
  source="./modules/iamRole"
  role_name = "ecsManagedInstanceInfrastructureRole"
  policies_to_attach = [data.aws_iam_policy.infra-role-policy,data.aws_iam_policy.infra-role-volume-policy]
  assume_role_policy = data.aws_iam_policy_document.ecs_assume_role_policy.json
}
