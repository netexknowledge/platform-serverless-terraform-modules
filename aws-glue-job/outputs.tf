output "job" {
  description = "Glue Job"
  value       = aws_glue_job.job
}

output "role" {
  description = "Glue Job Role"
  value       = aws_iam_role.glue_role
}

output "glue_bucket" {
  description = "Glue S3 bucket"
  value       = var.s3_create_bucket_glue ? aws_s3_bucket.glue_bucket[0] : null
}
