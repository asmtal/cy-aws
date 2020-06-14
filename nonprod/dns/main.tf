resource "aws_route53_zone" "route53_zone" {
  name = "${var.environment}.yaameh.com"
}

output "route53_zone" {
  value = aws_route53_zone.route53_zone
}
