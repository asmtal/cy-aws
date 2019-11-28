resource "aws_iam_group" "administrators" {
  name = "administrators"
}

resource "aws_iam_group_policy_attachment" "administrators_AdministratorAccess" {
  group      = aws_iam_group.administrators.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_user" "cmbrad" {
  name = "cmbrad"
}

resource "aws_iam_user_group_membership" "cmbrad" {
  user = aws_iam_user.cmbrad.name

  groups = [
    aws_iam_group.administrators.name,
  ]
}

resource "aws_iam_user" "automation" {
  name = "automation"
}

resource "aws_iam_user_group_membership" "automation" {
  user = aws_iam_user.automation.name

  groups = [
    aws_iam_group.administrators.name,
  ]
}
