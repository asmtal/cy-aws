resource "aws_security_group" "security_group" {
  name_prefix = "grafana-"
  vpc_id      = var.vpc_id

  ingress {
    description = "Traffic to self"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
  }

  ingress {
    description = "Grafana Web UI from specific IP"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["${var.outbound_ip}/32"]
  }

  ingress {
    description = "SSH from specific IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.outbound_ip}/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "grafana"
    Application = "grafana"
  }
}
