# user_data

This module constructs EC2 user-data to be consumed with cloud-init. It installs standard services such as promtail, prometheus exporters, and related services.

## Example

```hcl
module "user_data" {
  source = "../user_data"

  scripts = [templatefile("${path.module}/files/install_efs.sh", {EfsFilesystemId = aws_efs_file_system.efs_file_system.id}), file("${path.module}/files/install_grafana.sh")]

  promtail_address = var.promtail_address
}
```
