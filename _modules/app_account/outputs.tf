output "account_id" {
  value = aws_organizations_account.account.id
}

output "default_vpc_id" {
  value = aws_default_vpc.default_vpc.id
}
