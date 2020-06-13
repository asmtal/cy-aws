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

resource "aws_spot_instance_request" "instance" {
  ami              = data.aws_ami.ubuntu.id
  instance_type    = "t3a.small"
  key_name         = var.ssh_key_name
  user_data_base64 = data.template_cloudinit_config.config.rendered

  vpc_security_group_ids = [aws_security_group.security_group.id]

  spot_type            = "one-time"
  wait_for_fulfillment = true

  tags = {
    Name        = "loki"
    Application = "loki"
  }
}

data "template_cloudinit_config" "config" {
  gzip          = true
  base64_encode = true

  part {
    content_type = "text/cloud-config"
    content      = templatefile("${path.module}/files/write_file.tpl", {
      Files = [
        {
          Path    = "/opt/loki/loki-config.yml"
          Content = base64encode(file("${path.module}/files/loki-config.yml"))
        },
        {
          Path    = "/etc/systemd/system/loki.service"
          Content = base64encode(file("${path.module}/files/loki.service"))
        },
        {
          Path    = "/opt/promtail/promtail-config.yml"
          Content = base64encode(file("${path.module}/files/promtail-config.yml"))
        },
        {
          Path    = "/etc/systemd/system/promtail.service"
          Content = base64encode(file("${path.module}/files/promtail.service"))
        }
      ]
    })
  }

  part {
    merge_type   = "list(append)+dict(recurse_array)+str()"
    content_type = "text/x-shellscript"
    content      = file("${path.module}/files/install_loki.sh")
  }

  part {
    merge_type   = "list(append)+dict(recurse_array)+str()"
    content_type = "text/x-shellscript"
    content      = file("${path.module}/files/install_promtail.sh")
  }
}
