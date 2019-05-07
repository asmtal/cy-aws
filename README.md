# AWS Accounts

This repository contains Terraform code which describes my personal AWS accounts.

The master account contains all IAM users, and from there roles can be assumed to access
sandpit / nonprod / prod / other accounts. All accounts are created in an organisation in
the master account.

## Example

```powershell
$ENV:AWS_DEFAULT_REGION="ap-southeast-2"
cd nonprod
terraform apply
```

## TODO

* Set up a Makefile to make it easier to deploy all at once
* Set up Atlantis
