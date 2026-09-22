output "glue_connection" {
  description = "Glue connection"
  value       = aws_glue_connection.connection
}

output "s3_object_driver" {
  description = "S3 object of Glue driver"
  value       = var.connector_file_path != null ? aws_s3_object.glue_driver_path[0].id : null
}
