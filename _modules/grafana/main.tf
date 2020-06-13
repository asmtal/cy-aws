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
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3a.small"
  key_name      = var.ssh_key_name
  user_data     = file("${path.module}/files/install_grafana.sh")

  vpc_security_group_ids = [aws_security_group.security_group.id]

  spot_type            = "one-time"
  wait_for_fulfillment = true

  tags = {
    Name        = "grafana"
    Application = "grafana"
  }
}
