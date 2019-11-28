terraform {
  backend "remote" {
    organization = "cmbrad"

    workspaces {
      name = "master"
    }
  }
}

module "master" {
  source = "../_modules/master_account"
}

module "sandpit" {
  source        = "../_modules/app_account"
  account_name  = "sandpit"
  account_email = "chris.bradley+sandpit@cy.id.au"
}

module "nonprod" {
  source        = "../_modules/app_account"
  account_name  = "nonprod"
  account_email = "chris.bradley+nonprod@cy.id.au"
}

module "prod" {
  source        = "../_modules/app_account"
  account_name  = "prod"
  account_email = "chris.bradley+prod@cy.id.au"
}
