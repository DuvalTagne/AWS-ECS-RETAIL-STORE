resource "aws_iam_role" "role" {
  name                = var.role_name
  assume_role_policy  = ""

}

resource "aws_iam_policy_attachment" "policy_attach_role" {
  
  name = "${var.role_name}-attachment"
  roles=aws_iam_role.role.name
  policy_arn = each.value
}