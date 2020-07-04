server = true
bootstrap_expect = 1

ui = true

data_dir = "/tmp/consul"
client_addr = "0.0.0.0"

telemetry {
  prometheus_retention_time = "12m"
  disable_hostname          = true
}
