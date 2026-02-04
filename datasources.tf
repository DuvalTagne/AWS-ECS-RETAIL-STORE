data "aws_iam_policy" "infra-role-policy" {
  name = "AmazonECSInfrastructureRolePolicyForManagedInstances"
}
data "aws_iam_policy" "instance-role-policy" {
  name = "AmazonECSInstanceRolePolicyForManagedInstances"
}
data "aws_iam_policy" "infra-role-volume-policy" {
  name = "AmazonECSInfrastructureRolePolicyForVolumes"
}

data "aws_iam_policy_document" "ecs_assume_role_policy" {
  statement {
    actions = [ "sts:AssumeRole" ]
    principals {
      type = "Service"
      identifiers = [ "ec2.amazonaws.com" ]
    }
  }
}