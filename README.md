# AWS Accounts

This repository contains Terraform code which describes my personal AWS accounts.

The master account contains all IAM users, and from there roles can be assumed to access
sandpit / nonprod / prod accounts. All accounts are created in an organisation in
the master account.

## Example

```powershell
cd nonprod
terraform apply
```

## TODO

* Switch to Terragrunt to separate state
