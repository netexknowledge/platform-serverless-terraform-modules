# iam role to allow glue job to access s3 bucket
resource "aws_iam_role" "glue_role" {
  name = "${local.product_name}-${var.name}-glue-job"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "glue.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "glue_role_policy" {
  role       = aws_iam_role.glue_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
}

resource "aws_iam_policy" "glue_s3_bucket_created_policy" {
  count = var.s3_create_bucket_glue ? 1 : 0

  name        = "${local.product_name}-${var.name}-glue-bucketS3-policy"
  description = "IAM policy for glue job to access s3 bucket"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "s3:*"
        Effect = "Allow"
        Resource = [
          aws_s3_bucket.glue_bucket[0].arn,
          "${aws_s3_bucket.glue_bucket[0].arn}/*"
        ]
      }
    ]
  })
}

resource "aws_iam_policy" "glue_s3_bucket_policy" {
  count = var.s3_create_bucket_glue == false ? var.s3_bucket_glue_name != "" ? 1 : 0 : 0

  name        = "${local.product_name}-${var.name}-glue-bucketS3-policy"
  description = "IAM policy for glue job to access s3 bucket"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "s3:*"
        Effect = "Allow"
        Resource = [
          "arn:aws:s3:::${var.s3_bucket_glue_name}",
          "arn:aws:s3:::${var.s3_bucket_glue_name}/*"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "glue_policy_attachment" {
  count = var.s3_create_bucket_glue ? 1 : 0

  role       = aws_iam_role.glue_role.name
  policy_arn = aws_iam_policy.glue_s3_bucket_created_policy[0].arn
}

resource "aws_iam_role_policy_attachment" "glue_s3_bucket_policy_attachment" {
  count = var.s3_create_bucket_glue == false ? var.s3_bucket_glue_name != "" ? 1 : 0 : 0

  role       = aws_iam_role.glue_role.name
  policy_arn = aws_iam_policy.glue_s3_bucket_policy[0].arn
}
