module "hotham_ticket_alert" {
  source = "github.com/cmbrad/hotham-ticket-alert//terraform?ref=master"

  environment = var.environment
}
