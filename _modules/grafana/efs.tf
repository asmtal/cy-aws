resource "aws_efs_file_system" "efs_file_system" {
  tags = {
    Name        = "prometheus"
    Application = "prometheus"
  }
}

data "aws_subnet_ids" "subnet_ids" {
  vpc_id = var.vpc_id
}

resource "aws_efs_mount_target" "efs_mount_target" {
  for_each = data.aws_subnet_ids.subnet_ids.ids

  security_groups = [aws_security_group.security_group.id]
  file_system_id  = aws_efs_file_system.efs_file_system.id
  subnet_id       = each.value
}
