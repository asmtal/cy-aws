# prometheus

This module builds Prometheus on AWS. It integrates with Loki/Promtail for centralised logging and is intended to be paired with Grafana.

## Example

```hcl
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
```
