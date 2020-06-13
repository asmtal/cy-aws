terraform {
  backend "s3" {
    bucket = "cy-terraform"
    key    = "cy-aws-sandpit"
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
    role_arn = "arn:aws:iam::${data.terraform_remote_state.master.outputs.sandpit.account_id}:role/administrators"
  }
}

module "public_ip" {
  source = "../_modules/public_ip"
}

resource "aws_key_pair" "personal" {
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDpYH6tgv2IvFms1/4X5PZrrYYOUOGW8JsMmv2hFXBe3V5Ov+P4AHfyEbYs8zderh1WoheP2GmGt+gdtJmOFBIK6iAKQwEySCNalGg4Zyzhw3wYVcDfHQbV76Sv5gzSftSFG+uabQHcFEvqfItHWqeG5EVru78TKMJ3NxCuZ+hesavNg+9ctwOELGpMacTnRF56vmDgKap6Jhe5nvyGwNdsW4WyaC3pRO4BC77pKQZ8qXql329L4avo144wyhnXIAubOuymGiA/5hqT/KK7dBzlK9WnBVbGN3rSxl8TOkksu2dnmDuyAsjDYP7syA/JFQtA7caad7cgGEWx/V8srzkd chris@DESKTOP-KHS4OSJ"
}
