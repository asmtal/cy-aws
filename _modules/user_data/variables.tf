variable "files" {
  type = list(object({
    Path    = string
    Content = string
  }))
  description = "List of files to copy onto the instance"
  default = []
}

variable "scripts" {
  type        = list(string)
  description = "List of paths to scripts to run when instance launches"
  default     = []
}

variable "promtail_address" {
  type    = string
  default = "http://127.0.0.1:3100/loki/api/v1/push"
}

locals {
  default_files = [
    {
      Path    = "/opt/promtail/promtail-config.yml"
      Content = file("${path.module}/files/promtail-config.yml")
    },
    {
      Path    = "/etc/systemd/system/promtail.service"
      Content = templatefile("${path.module}/files/promtail.service", {PromtailAddress = var.promtail_address})
    },
    {
      Path    = "/etc/systemd/system/node_exporter.service"
      Content = file("${path.module}/files/node_exporter.service")
    }
  ]
  default_scripts = ["${path.module}/files/install_node_exporter.sh", "${path.module}/files/install_promtail.sh"]

  files = [{
    content_type = "text/cloud-config"
    content      = templatefile("${path.module}/files/write_file.tpl", {
      Files = [for f in concat(local.default_files, var.files): {Path = f.Path, Content = base64encode(f.Content)}]
    })
  }]
  scripts = [for s in concat(local.default_scripts, var.scripts): {content_type = "text/x-shellscript", content = file(s)}]

  parts = concat(local.files, local.scripts)
}
