terraform {
    required_version = "~> 1.8"
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 5.47"
        }
    }
}

provider "aws" {
    region = var.region
    profile = var.profile
}

# S3 bucket for terraform state file
resource "aws_s3_bucket" "terraform_state" {
    bucket = var.bucket
    force_destroy = true

  tags = {
    Created_by = var.tag_created_by
  }
}

# S3 bucket versioning enabled
resource "aws_s3_bucket_versioning" "terraform_state_versioning" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Server side encryption algorithm set to AES256
resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "AES256"
    }
  }
}

# DynamoDB table for storing state locks
resource "aws_dynamodb_table" "terraform_locks" {
    name = var.dynamodb_table
    billing_mode = "PAY_PER_REQUEST"
    hash_key = "LockID"
    attribute {
        name = "LockID"
        type = "S"
    }
}