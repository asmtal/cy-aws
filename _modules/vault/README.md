# vault

This module installs Hashicorp Vault on AWS. It configures Vault with Consul storage.

## Example

```hcl
module "vault" {
  source = "../../_modules/vault"

  vpc_id       = data.terraform_remote_state.accounts.outputs.sandpit.default_vpc_id
  outbound_ip  = module.public_ip.ip
  ssh_key_name = aws_key_pair.personal.key_name

  hostname        = "vault.${var.environment}.yaameh.com"
  route53_zone_id = data.terraform_remote_state.dns.outputs.route53_zone.zone_id

  promtail_address = data.terraform_remote_state.monitoring.outputs.loki.promtail_address

  consul_cluster_id = data.terraform_remote_state.consul.outputs.consul.consul_cluster_id
}
```
