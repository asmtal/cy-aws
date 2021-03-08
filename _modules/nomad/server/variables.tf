variable "vpc_id" {}

variable "outbound_ip" {}

variable "ssh_key_name" {}

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

variable "cluster_id" {
  type    = string
  default = ""
}

variable "consul_cluster_id" {
  type = string
}

variable "cluster_size" {
  type    = number
  default = 1
}

locals {
  cluster_id = length(var.cluster_id) > 0 ? var.cluster_id : try(random_uuid.cluster_id[0].result, "")
}
