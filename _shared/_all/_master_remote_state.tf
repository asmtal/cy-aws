data "terraform_remote_state" "accounts" {
  backend = "s3"

  config = {
    bucket = "cy-terraform"
    key    = "master/accounts/terraform.tfstate"
    region = "ap-southeast-2"
  }
}
