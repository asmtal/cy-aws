# AWS Accounts

This repository contains Terraform code which describes my personal AWS accounts.

The master account contains all IAM users, and from there roles can be assumed to access
sandpit / nonprod / prod accounts. All accounts are created in an organisation in
the master account.

## TODO

Setup Atlantis or similar to run against git commits.

## Actions
### Init

```bash
# called implicitly by plan
make project=sandpit/monitoring init

# force a new init if modules have changed
make project=sandpit/monitoring initf
```

### Plan & Apply

```bash
# plan and write plan to file
make project=sandpit/monitoring plan

# apply plan created earlier
make project=sandpit/monitoring apply
```

### Ad hoc commands

```bash
# command without common variables set
make project=master/accounts terraform cmd="state list"

# command with common variables set
make project=master/accounts terraformv cmd="state list"
```

### Clean

```bash
# clean everything not stored in git
make clean
```

## Workflow
### Add new resources

If they belong to a new application then make a new directory under the appropriate account.

If they belong to an existing application then modify/create new `*.tf` files in the appropriate directory.

Any sub directories will be allocated a separate Terraform state and must be planned separately.


### Delete resources

1. Delete code
2. `plan` then `apply`
3. Commit and push

### Restore deleted resources

1. git revert commit where resources where deleted
2. `plan` then `apply`
3. Commit and push
