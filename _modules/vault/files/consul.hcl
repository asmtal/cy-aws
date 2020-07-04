server = false

data_dir = "/tmp/consul"
client_addr = "0.0.0.0"

telemetry {
  prometheus_retention_time = "12m"
  disable_hostname          = true
}
