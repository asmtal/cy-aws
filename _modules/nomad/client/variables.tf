variable "vpc_id" {}

variable "outbound_ip" {}

variable "ssh_key_name" {}

variable "instance_type" {
  type        = string
  description = "Type of AWS instance to launch"
  default     = "t3a.nano"
}

variable "promtail_address" {
  type = string
}

variable "cluster_id" {
  type = string
}

variable "consul_cluster_id" {
  type = string
}

variable "cluster_size" {
  type    = number
  default = 1
}
