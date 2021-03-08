# grafana

This module builds Grafana on AWS. It integrates with promtail for centraliesd logging purposes.

## Example

```hcl
module "grafana" {
  source = "../../_modules/grafana"

  vpc_id       = data.terraform_remote_state.accounts.outputs.sandpit.default_vpc_id
  outbound_ip  = module.public_ip.ip
  ssh_key_name = aws_key_pair.personal.key_name

  hostname        = "grafana.${var.environment}.yaameh.com"
  route53_zone_id = data.terraform_remote_state.dns.outputs.route53_zone.zone_id

  promtail_address = module.loki.promtail_address
}
```
