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

# generate cluster ID randomly unless an overriden one is provided as a var
resource "random_uuid" "cluster_id" {
  count = length(var.cluster_id) > 0 ? 0 : 1
}

module "user_data" {
  source = "../../user_data"

  files = [
    {
      Path    = "/opt/nomad/config/server.hcl"
      Content = templatefile("${path.module}/files/server.hcl", { BootstrapExpect = var.cluster_size, NomadClusterId = local.cluster_id })
    },
    {
      Path    = "/etc/systemd/system/nomad.service"
      Content = file("${path.module}/files/nomad.service")
    },
  ]
  scripts = [file("${path.module}/files/install_nomad.sh")]

  promtail_address = var.promtail_address

  consul_cluster_id = var.consul_cluster_id
}

resource "aws_spot_instance_request" "instance" {
  count = var.cluster_size

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

locals {
  tags = {Name = var.hostname, Application = "nomad", Role = "server", NomadClusterId = local.cluster_id}
  instance_tags = flatten([
    for ins in range(var.cluster_size) : [
      for k, v in local.tags : {
        id          = ins
        tag_key     = k
        tag_value   = v
      }
    ]
  ])
}

resource "aws_ec2_tag" "ec2_tag" {
  for_each = {
    for tag in local.instance_tags : "${tag.id}-${tag.tag_key}" => tag
  }

  resource_id = aws_spot_instance_request.instance[each.value.id].spot_instance_id
  key         = each.value.tag_key
  value       = each.value.tag_value
}

resource "aws_route53_record" "route53_record" {
  zone_id = var.route53_zone_id
  name    = var.hostname
  type    = "A"
  ttl     = "300"
  records = aws_spot_instance_request.instance[*].public_ip
}
