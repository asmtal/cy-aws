resource "aws_organizations_account" "account" {
  name                       = var.account_name
  email                      = var.account_email
  iam_user_access_to_billing = "ALLOW"
}
