bind_addr = "0.0.0.0"

log_level = "DEBUG"
data_dir  = "/opt/nomad"

client {
  enabled = true

  server_join {
    retry_join = ["provider=aws tag_key=NomadClusterId tag_value=${NomadClusterId} addr_type=private_v4"]
  }
}

advertise {
  http = "{{ advertise_http }}"
}

# we update out of band, no point checking
disable_update_check = true
# clients are gonna disappear and never come back
leave_on_terminate   = true
