resource "aws_dynamodb_table" "dynamodb_table" {
  name = format("%s-%s", local.product_name, var.suffix)

  billing_mode   = var.billing_mode
  read_capacity  = var.read_capacity
  write_capacity = var.write_capacity
  stream_enabled = var.stream_enabled

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

  name               = "DynamoDBReadCapacityUtilization:${aws_appautoscaling_target.dynamodb_table_write_target[0].resource_id}"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.dynamodb_table_write_target[0].resource_id
  scalable_dimension = aws_appautoscaling_target.dynamodb_table_write_target[0].scalable_dimension
  service_namespace  = aws_appautoscaling_target.dynamodb_table_write_target[0].service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "DynamoDBReadCapacityUtilization"
    }

    target_value = lookup(var.autoscaling.write, "target_utilization", 70)
  }
}
