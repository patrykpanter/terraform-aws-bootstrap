variable "bucket" {
    description = "Name of a bucket used to store state file"
    type = string
}

variable "profile" {
    description = "AWS CLI profile used to execute the bootstrapping process"
    type = string
    default = "default"
}

variable "region" {
    description = "Region where the S3 bucket and DynamoDB table are created"
    type = string
}

variable "tag_created_by" {
    description = "Created_by tag used to identify resources created by this project"
    type = string
    default = "terraform-bootstrap"
}