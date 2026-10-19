resource "aws_dynamodb_table" "dynamodb_table" {
  name = local.resource_name

  deletion_protection_enabled = var.delete_protection

  billing_mode   = var.billing_mode
  read_capacity  = var.read_capacity
  write_capacity = var.write_capacity

  # Una Global Table replica a traves del stream de la tabla, asi que replicar
  # obliga a tenerlo encendido y con imagenes nueva y vieja. Se fuerza aqui en
  # vez de pedirselo a quien declara la tabla: es un requisito de DynamoDB, no
  # una preferencia, y dejarlo a mano solo sirve para que el apply falle luego.
  #
  # stream_view_type faltaba por completo en el modulo: con stream_enabled a
  # true y sin tipo de vista, AWS rechaza la tabla. Por eso se declara tambien
  # para el caso sin replica.
  stream_enabled   = length(var.replica_regions) > 0 ? true : var.stream_enabled
  stream_view_type = length(var.replica_regions) > 0 ? "NEW_AND_OLD_IMAGES" : (var.stream_enabled ? var.stream_view_type : null)

  # Global Tables v2. La replica lleva EL MISMO nombre de tabla que la original:
  # DynamoDB no admite sufijo ni renombrado, la tabla es la misma vista desde
  # otra region. Eso tiene una ventaja practica: una lambda desplegada en la
  # region de DR no necesita saber nada, con apuntar al nombre de siempre ya
  # habla con la replica local.
  dynamic "replica" {
    for_each = toset(var.replica_regions)

    content {
      region_name            = replica.value
      point_in_time_recovery = var.point_in_time_recovery
      propagate_tags         = true
    }
  }

  dynamic "attribute" {
    for_each = var.attributes

    content {
      name = attribute.value.name
      type = attribute.value.type
    }
  }

  hash_key = var.hash_key

  dynamic "global_secondary_index" {
    for_each = var.global_secondary_indexes

    content {
      name            = global_secondary_index.value.name
      hash_key        = global_secondary_index.value.hash_key
      projection_type = global_secondary_index.value.projection_type
      range_key       = lookup(global_secondary_index.value, "range_key", null)
      read_capacity   = lookup(global_secondary_index.value, "read_capacity", null)
      write_capacity  = lookup(global_secondary_index.value, "write_capacity", null)

      non_key_attributes = lookup(global_secondary_index.value, "non_key_attributes", null)
    }
  }

  point_in_time_recovery {
    enabled = var.point_in_time_recovery
  }

  tags = var.tags

  lifecycle {
    precondition {
      # Con PROVISIONED, DynamoDB exige autoescalado de escritura en todas las
      # replicas antes de dejar crear la Global Table. Sin esto el apply llega
      # hasta AWS y muere alli con un mensaje mucho menos claro que este.
      condition     = length(var.replica_regions) == 0 || var.billing_mode == "PAY_PER_REQUEST" || lookup(var.autoscaling, "write", null) != null
      error_message = "Para replicar en otra region con billing_mode PROVISIONED hace falta autoscaling de escritura (autoscaling.write). Con PAY_PER_REQUEST no hace falta nada."
    }
  }
}

resource "aws_appautoscaling_target" "dynamodb_table_read_target" {
  count = lookup(var.autoscaling, "read", null) != null ? 1 : 0

  max_capacity       = lookup(var.autoscaling.read, "max_capacity", 10)
  min_capacity       = lookup(var.autoscaling.read, "min_capacity", 1)
  resource_id        = format("table/%s", aws_dynamodb_table.dynamodb_table.id)
  scalable_dimension = "dynamodb:table:ReadCapacityUnits"
  service_namespace  = "dynamodb"
}

resource "aws_appautoscaling_policy" "dynamodb_table_read_policy" {
  count = lookup(var.autoscaling, "read", null) != null ? 1 : 0

  name               = "DynamoDBReadCapacityUtilization:${aws_appautoscaling_target.dynamodb_table_read_target[0].resource_id}"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.dynamodb_table_read_target[0].resource_id
  scalable_dimension = aws_appautoscaling_target.dynamodb_table_read_target[0].scalable_dimension
  service_namespace  = aws_appautoscaling_target.dynamodb_table_read_target[0].service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "DynamoDBReadCapacityUtilization"
    }

    target_value = lookup(var.autoscaling.read, "target_utilization", 70)
  }
}

resource "aws_appautoscaling_target" "dynamodb_table_write_target" {
  count = lookup(var.autoscaling, "write", null) != null ? 1 : 0

  max_capacity       = lookup(var.autoscaling.write, "max_capacity", 10)
  min_capacity       = lookup(var.autoscaling.write, "min_capacity", 1)
  resource_id        = format("table/%s", aws_dynamodb_table.dynamodb_table.id)
  scalable_dimension = "dynamodb:table:WriteCapacityUnits"
  service_namespace  = "dynamodb"
}

resource "aws_appautoscaling_policy" "dynamodb_table_write_policy" {
  count = lookup(var.autoscaling, "write", null) != null ? 1 : 0

  name               = "DynamoDBWriteCapacityUtilization:${aws_appautoscaling_target.dynamodb_table_write_target[0].resource_id}"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.dynamodb_table_write_target[0].resource_id
  scalable_dimension = aws_appautoscaling_target.dynamodb_table_write_target[0].scalable_dimension
  service_namespace  = aws_appautoscaling_target.dynamodb_table_write_target[0].service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "DynamoDBWriteCapacityUtilization"
    }

    target_value = lookup(var.autoscaling.write, "target_utilization", 70)
  }
}
