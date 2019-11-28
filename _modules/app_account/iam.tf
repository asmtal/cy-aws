# Assume role into the new account so baseline can be configured
provider "aws" {
  version = "~> 2.0"

  assume_role {
    role_arn = "arn:aws:iam::${aws_organizations_account.account.id}:role/OrganizationAccountAccessRole"
  }

  alias = "account"
}

# Give master account access to assume these new roles
data "aws_caller_identity" "master" {}

data "aws_iam_policy_document" "administrators_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = [data.aws_caller_identity.master.account_id]
    }
  }
}

resource "aws_iam_role" "administrators" {
  name               = "administrators"
  assume_role_policy = data.aws_iam_policy_document.administrators_assume_role_policy.json

  provider = "aws.account"
}

resource "aws_iam_role_policy_attachment" "administrators_AdministratorAccess" {
  role       = aws_iam_role.administrators.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"

  provider = "aws.account"
}
