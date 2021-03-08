provider "aws" {
  region  = "ap-southeast-2"

  assume_role {
    role_arn = "arn:aws:iam::${data.terraform_remote_state.accounts.outputs.sandpit.account_id}:role/administrators"
  }
}
