# CY-AWS

This repository contains all terraform definitions required to provision the infrastructure and applications in my AWS accounts.

## Usage

### Plan

```bash
# format: make project=environment/application plan
make project=sandpit/consul plan
```

### Apply

```bash
# format: make project=environment/application apply
make project=sandpit/consul apply
```

## Applications

### Start Order

* DNS
* Consul
* Vault
* Monitoring
* Nomad

### Monitoring

* Grafana
* Prometheus
* Loki

### Support

* Hashicorp Vault
* Hashicorp Consul
