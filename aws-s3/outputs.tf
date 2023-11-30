output "bucket_id" {
  description = "value of bucket id"
  value       = aws_s3_bucket.bucket.id
}

output "bucket_arn" {
  description = "value of bucket arn"
  value       = aws_s3_bucket.bucket.arn
}

output "bucket_regional_domain_name" {
  description = "value of bucket regional domain name"
  value       = aws_s3_bucket.bucket.bucket_regional_domain_name
}
