module "public_ip" {
  source = "../../_modules/public_ip"
}

data "terraform_remote_state" "dns" {
  backend = "s3"

  config = {
    bucket = "cy-terraform"
    key    = "sandpit/dns/terraform.tfstate"
    region = "ap-southeast-2"
  }
}

module "loki" {
  source = "../../_modules/loki"

  vpc_id       = data.terraform_remote_state.accounts.outputs.sandpit.default_vpc_id
  outbound_ip  = module.public_ip.ip
  ssh_key_name = aws_key_pair.personal.key_name

  hostname        = "loki.${var.environment}.yaameh.com"
  route53_zone_id = data.terraform_remote_state.dns.outputs.route53_zone.zone_id
}

module "grafana" {
  source = "../../_modules/grafana"

  vpc_id       = data.terraform_remote_state.accounts.outputs.sandpit.default_vpc_id
  outbound_ip  = module.public_ip.ip
  ssh_key_name = aws_key_pair.personal.key_name

  hostname        = "grafana.${var.environment}.yaameh.com"
  route53_zone_id = data.terraform_remote_state.dns.outputs.route53_zone.zone_id

  promtail_address = module.loki.promtail_address
}

module "prometheus" {
  source = "../../_modules/prometheus"

  vpc_id       = data.terraform_remote_state.accounts.outputs.sandpit.default_vpc_id
  outbound_ip  = module.public_ip.ip
  ssh_key_name = aws_key_pair.personal.key_name

  grafana_sg_id = module.grafana.sg_id

  hostname        = "prometheus.${var.environment}.yaameh.com"
  route53_zone_id = data.terraform_remote_state.dns.outputs.route53_zone.zone_id

  promtail_address = module.loki.promtail_address
}

output "loki" {
  value = module.loki
}

output "grafana" {
  value = module.grafana
}

output "prometheus" {
  value = module.prometheus
}
