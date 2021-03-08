output "private_ips" {
  value = aws_spot_instance_request.instance[*].private_ip
}

output "public_ips" {
  value = aws_spot_instance_request.instance[*].public_ip
}

output "sg_id" {
  value = aws_security_group.security_group.id
}

output "hostname" {
  value = var.hostname
}

output "address" {
  value = "http://${var.hostname}:4646/"
}

output "cluster_id" {
  value = local.cluster_id
}
