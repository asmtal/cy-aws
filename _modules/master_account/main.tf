data "aws_caller_identity" "master" {}

resource "aws_organizations_organization" "this" {
  feature_set = "ALL"
}
