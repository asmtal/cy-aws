variable "vpc_id" {}

variable "outbound_ip" {}

variable "ssh_key_name" {}

variable "grafana_sg_id" {}

variable "instance_type" {
  type        = string
  description = "Type of AWS instance to launch"
  default     = "t3a.nano"
}

variable "hostname" {
  type = string
}

variable "route53_zone_id" {
  type        = string
  description = "Route53 zone to create hostname record in"
}

variable "promtail_address" {
  type = string
}
