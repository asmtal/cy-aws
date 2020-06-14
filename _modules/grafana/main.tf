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

  scripts = ["${path.module}/files/install_grafana.sh"]

  promtail_address = var.promtail_address
}

resource "aws_spot_instance_request" "instance" {
  ami           = data.aws_ami.ubuntu.id
  key_name      = var.ssh_key_name
  instance_type = var.instance_type
  user_data     = module.user_data.user_data

  vpc_security_group_ids = [aws_security_group.security_group.id]

  spot_type                       = "persistent"
  instance_interruption_behaviour = "stop"
  wait_for_fulfillment            = true

  tags = {
    Name        = var.hostname
    Application = "grafana"
  }
}

resource "aws_route53_record" "route53_record" {
  zone_id = var.route53_zone_id
  name    = var.hostname
  type    = "CNAME"
  ttl     = "300"
  records = [aws_spot_instance_request.instance.public_dns]
}
