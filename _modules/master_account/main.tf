provider "aws" {
  version = "~> 2.0"
}

data "aws_caller_identity" "master" {}

resource "aws_organizations_organization" "this" {
  feature_set = "ALL"
}
