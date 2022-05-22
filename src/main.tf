locals {
  vpc_id = element(split("/", var.network.data.infrastructure.arn), 1)
  mysql = {
    protocol = "tcp"
    port     = 3306
  }

  paramter_group_family = "mysql${var.database.engine_version}"
}

resource "random_password" "root_password" {
  length  = 10
  special = false
}

resource "random_id" "snapshot_identifier" {
  byte_length = 4
}

resource "aws_db_instance" "main" {
  identifier                  = var.md_metadata.name_prefix
  engine                      = "mysql"
  allow_major_version_upgrade = false
  auto_minor_version_upgrade  = true

  engine_version = var.database.engine_version
  username       = var.database.username
  password       = random_password.root_password.result
  instance_class = var.database.instance_class

  publicly_accessible = false
  port                = local.mysql.port

  allocated_storage     = var.storage.allocated
  max_allocated_storage = var.storage.max_allocated
  storage_type          = var.storage.type
  iops                  = lookup(var.storage, "iops", null)

  # TODO: disk encryption if storage_encrypted is set to true and a kms key is used, will it use the kms key
  # is this field even needed then?
  storage_encrypted = true
  kms_key_id        = aws_kms_key.mysql_encryption.arn

  # TODO: can we enabled this w/o requiring IAM (ie, using mysql pw)
  # iam_database_authentication_enabled = var.iam_database_authentication_enabled

  # TODO: accept vpc_security_group_ids
  # vpc_security_group_ids              = compact(concat(aws_security_group.main.*.id, var.vpc_security_group_ids))  

  vpc_security_group_ids    = [aws_security_group.main.id]
  db_subnet_group_name      = aws_db_subnet_group.main.name
  parameter_group_name      = aws_db_parameter_group.main.name
  copy_tags_to_snapshot     = true
  deletion_protection       = var.database.deletion_protection
  skip_final_snapshot       = var.backup.skip_final_snapshot
  final_snapshot_identifier = var.backup.skip_final_snapshot ? null : "${var.md_metadata.name_prefix}-${element(concat(random_id.snapshot_identifier.*.hex, [""]), 0)}"
  backup_retention_period   = var.backup.retention_period
  delete_automated_backups  = var.backup.delete_automated_backups
  # TODO: best way to represent this in the UI?
  # Need time-only widget: https://github.com/rjsf-team/react-jsonschema-form/tree/3ec17f1c0ff40401b7a99c5e9891ac2834a1e73f/packages/core/src/components/widgets
  # backup_window           = var.backup_window  

  lifecycle {
    ignore_changes = [
      latest_restorable_time
    ]
  }
}

resource "aws_db_subnet_group" "main" {
  name        = var.md_metadata.name_prefix
  description = "For RDS MySQL cluster ${var.md_metadata.name_prefix}"
  subnet_ids  = [for subnet in var.network.data.infrastructure.private_subnets : element(split("/", subnet["arn"]), 1)]
}

resource "aws_kms_key" "mysql_encryption" {
  description             = "MySQL Encryption Key for ${var.md_metadata.name_prefix}"
  deletion_window_in_days = 30
  # policy                  = data.aws_iam_policy_document.flow_log_encryption_key_policy[each.key].json  
  # multi_region = ?
  # enable_key_rotation = ?
}

resource "aws_kms_alias" "mysql_encryption" {
  name          = "alias/${var.md_metadata.name_prefix}-mysql-encryption"
  target_key_id = aws_kms_key.mysql_encryption.key_id
}

resource "aws_security_group" "main" {
  vpc_id      = local.vpc_id
  name_prefix = "${var.md_metadata.name_prefix}-"
  description = "Control traffic to/from RDS MySQL ${var.md_metadata.name_prefix}"
}

# TODO: Remove this once we have application bundles working.
resource "aws_security_group_rule" "vpc_ingress" {
  count       = var.networking.allow_vpc_access ? 1 : 0
  description = "From allowed CIDRs"
  type        = "ingress"
  from_port   = local.mysql.port
  to_port     = local.mysql.port
  protocol    = local.mysql.protocol
  cidr_blocks = [var.network.data.infrastructure.cidr]

  security_group_id = aws_security_group.main.id
}

resource "aws_db_parameter_group" "main" {
  name_prefix = var.md_metadata.name_prefix
  description = "Paramter group for RDS MySQL ${var.md_metadata.name_prefix}"
  family      = local.paramter_group_family

  dynamic "parameter" {
    for_each = var.parameters
    content {
      name         = parameter.value.name
      value        = parameter.value.value
      apply_method = lookup(parameter.value, "apply_method", null)
    }
  }

  tags = merge(
    var.tags,
    {
      "Name" = var.name
    },
  )

  lifecycle {
    create_before_destroy = true
  }
}

output "mysql" {
  value     = aws_db_instance.main
  sensitive = true
}
