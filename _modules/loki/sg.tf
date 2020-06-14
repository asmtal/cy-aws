data "aws_vpc" "vpc" {
  id = var.vpc_id
}

resource "aws_security_group" "security_group" {
  name_prefix = "loki-"
  vpc_id      = var.vpc_id

  ingress {
    description = "Traffic to self"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
  }

  ingress {
    description = "Loki Web interface from specific IP"
    from_port   = 3100
    to_port     = 3100
    protocol    = "tcp"
    cidr_blocks = ["${var.outbound_ip}/32"]
  }

  ingress {
    description = "Promtail Web interface from specific IP"
    from_port   = 9080
    to_port     = 9080
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

  ingress {
    description = "Inbound traffic from VPC"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [data.aws_vpc.vpc.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "loki"
    Application = "loki"
  }
}
