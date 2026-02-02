data "aws_iam_policy" "infra-role-policy" {
  name = "AmazonECSInfrastructureRolePolicyForManagedInstances"
}
data "aws_iam_policy" "instance-role-policy" {
  name = "AmazonECSInstanceRolePolicyForManagedInstances"
}
data "aws_iam_policy" "infra-role-volume-policy" {
  name = "AmazonECSInfrastructureRolePolicyForVolumes"
}