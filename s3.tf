
# S3 Bucket
resource "aws_s3_bucket" "logs_bucket" {
  bucket = "my-logs-bucket-${random_string.suffix.result}" # Unique bucket name

  tags = {
    Name = "Logs Bucket"
    Environment = "Dev"
  }
}

# Enable Versioning
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.logs_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Random Suffix for Bucket Name Uniqueness
resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

# Output the Bucket Name
output "s3_bucket_name" {
  description = "The name of the S3 bucket"
  value       = aws_s3_bucket.logs_bucket.bucket
}