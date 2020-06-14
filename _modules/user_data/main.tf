data "template_cloudinit_config" "config" {
  gzip          = true
  base64_encode = true

  dynamic "part" {
    for_each = local.parts

    content {
      content_type = part.value["content_type"]
      content      = part.value["content"]
    }
  }
}
