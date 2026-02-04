resource "aws_iam_role" "role" {
  name                = var.role_name
  assume_role_policy  = var.assume_role_policy

}

resource "aws_iam_policy_attachment" "policy_attach_role" {
  for_each = toset(var.policies_to_attach)
  name = "${var.role_name}-attachment-${each.key}"
  roles=[aws_iam_role.role.name]
  policy_arn = each.value
}