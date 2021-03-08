bind_addr = "0.0.0.0"

log_level = "DEBUG"
data_dir  = "/opt/nomad"

server {
  enabled          = true
  bootstrap_expect = ${BootstrapExpect}

  server_join {
    retry_join = ["provider=aws tag_key=NomadClusterId tag_value=${NomadClusterId} addr_type=private_v4"]
  }
}

disable_update_check = true
leave_on_terminate   = true
