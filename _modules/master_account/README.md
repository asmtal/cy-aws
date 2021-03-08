# master_account

This module creates an organisation in account, intending to use it as a `master` account. Applications should not be ran in this account, it's just a billing/management construct.

# Example

```hcl
module "master" {
  source = "../../_modules/master_account"
}
```
