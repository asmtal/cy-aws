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
    description = "Prometheus Web interface from specific IP"
    from_port   = 9090
    to_port     = 9090
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
    description     = "Inbound traffic from Grafana"
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [var.grafana_sg_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "prometheus"
    Application = "prometheus"
  }
}
