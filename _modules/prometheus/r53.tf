resource "aws_route53_record" "route53_record" {
  zone_id = var.route53_zone_id
  name    = var.hostname
  type    = "CNAME"
  ttl     = "300"
  records = [aws_spot_instance_request.instance.public_dns]
}
