output "private_ips" {
  value = aws_spot_instance_request.instance[*].private_ip
}

output "public_ips" {
  value = aws_spot_instance_request.instance[*].public_ip
}

output "sg_id" {
  value = aws_security_group.security_group.id
}
