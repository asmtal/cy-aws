data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

module "user_data" {
  source = "../user_data"

  files = [
    {
      Path    = "/opt/prometheus/prometheus-config.yml"
      Content = file("${path.module}/files/prometheus-config.yml")
    },
    {
      Path    = "/etc/systemd/system/prometheus.service"
      Content = file("${path.module}/files/prometheus.service")
    }
  ]
  scripts = ["${path.module}/files/install_prometheus.sh"]

  promtail_address = var.promtail_address
}

resource "aws_spot_instance_request" "instance" {
  ami                  = data.aws_ami.ubuntu.id
  key_name             = var.ssh_key_name
  instance_type        = var.instance_type
  user_data_base64     = module.user_data.user_data
  iam_instance_profile = aws_iam_instance_profile.iam_instance_profile.name

  vpc_security_group_ids = [aws_security_group.security_group.id]

  spot_type                       = "persistent"
  instance_interruption_behaviour = "stop"
  wait_for_fulfillment            = true

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "aws_ec2_tag" "ec2_tag" {
  for_each = {Name = var.hostname, Application = "prometheus"}

  resource_id = aws_spot_instance_request.instance.spot_instance_id
  key         = each.key
  value       = each.value
}

