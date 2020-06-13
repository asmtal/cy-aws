terraform {
  backend "s3" {
    bucket = "cy-terraform"
    region = "ap-southeast-2"
  }
}
