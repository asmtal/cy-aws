terraform {
  backend "s3" {
    bucket = "cy-terraform"
    key    = "cy-aws-prod"
    region = "ap-southeast-2"
  }
}

data "terraform_remote_state" "master" {
  backend = "s3"

  config = {
    bucket = "cy-terraform"
    key    = "cy-aws-master"
    region = "ap-southeast-2"
  }
}

provider "aws" {
  version = "~> 2.9"
  region  = "ap-southeast-2"

  assume_role {
    role_arn = "arn:aws:iam::${data.terraform_remote_state.master.outputs.prod_account_id}:role/administrators"
  }
}
