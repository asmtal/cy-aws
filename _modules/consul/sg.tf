data "aws_vpc" "vpc" {
  id = var.vpc_id
}

resource "aws_security_group" "security_group" {
  name_prefix = "prometheus-"
  vpc_id      = var.vpc_id

  ingress {
    description = "Traffic to self"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
  }

  ingress {
    description = "Consul Web interface from specific IP"
    from_port   = 8500
    to_port     = 8500
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
    Name        = "consul"
    Application = "consul"
  }
}
