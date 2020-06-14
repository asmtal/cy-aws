resource "aws_route53_zone" "main" {
  name = "yaameh.com"
}

resource "aws_route53_zone" "route53_zone" {
  name = "${var.environment}.yaameh.com"
}

output "route53_zone" {
  value = aws_route53_zone.route53_zone
}

data "terraform_remote_state" "dns" {
  for_each = local.accounts

  backend = "s3"

  config = {
    bucket = "cy-terraform"
    key    = "${each.value}/dns/terraform.tfstate"
    region = "ap-southeast-2"
  }
}

resource "aws_route53_record" "subdomain_ns" {
  for_each = local.accounts

  zone_id = aws_route53_zone.main.zone_id
  name    = "${each.value}.yaameh.com"
  type    = "NS"
  ttl     = "30"

  records = data.terraform_remote_state.dns[each.value].outputs.route53_zone.name_servers
}

locals {
  accounts = toset(["sandpit", "nonprod", "prod", "master"])
}
