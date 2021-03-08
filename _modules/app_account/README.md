# app_account

This module provisions an Application AWS Account. At the moment these accounts are named after environments (ie sandpit, nonprod, prod) and are members of a central `master` account.

## Example

This should be called from the master account to provision it via AWS Organisations.

```hcl
module "sandpit" {
  source        = "../../_modules/app_account"
  account_name  = "sandpit"
  account_email = "chris.bradley+sandpit@cy.id.au"
}
```
