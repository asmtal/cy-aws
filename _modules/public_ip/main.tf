# source = https://stackoverflow.com/questions/46763287/i-want-to-identify-the-public-ip-of-the-terraform-execution-environment-and-add
data "http" "public_ip" {
  url = "https://ifconfig.co/json"

  request_headers = {
    Accept = "application/json"
  }
}

output "ip" {
  value = jsondecode(data.http.public_ip.body).ip
}
