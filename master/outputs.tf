output "sandpit_account_id" {
  value = "${module.sandpit.account_id}"
}

output "nonprod_account_id" {
  value = "${module.nonprod.account_id}"
}

output "prod_account_id" {
  value = "${module.prod.account_id}"
}
