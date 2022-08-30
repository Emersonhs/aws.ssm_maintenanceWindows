resource "aws_s3_bucket" "s3_ssm" {
  bucket        = "aws-s3-ssm-${var.environment}"
  versioning{
    enabled = false
  }
  tags = {
    environment = var.environment
  }
}
