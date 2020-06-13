module "loki" {
  source = "../_modules/loki"

  vpc_id       = data.terraform_remote_state.master.outputs.sandpit.default_vpc_id
  outbound_ip  = module.public_ip.ip
  ssh_key_name = aws_key_pair.personal.key_name

  grafana_sg_id = module.grafana.sg_id
}

module "grafana" {
  source = "../_modules/grafana"

  vpc_id       = data.terraform_remote_state.master.outputs.sandpit.default_vpc_id
  outbound_ip  = module.public_ip.ip
  ssh_key_name = aws_key_pair.personal.key_name
}

module "prometheus" {
  source = "../_modules/prometheus"

  vpc_id       = data.terraform_remote_state.master.outputs.sandpit.default_vpc_id
  outbound_ip  = module.public_ip.ip
  ssh_key_name = aws_key_pair.personal.key_name

  grafana_sg_id = module.grafana.sg_id
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
