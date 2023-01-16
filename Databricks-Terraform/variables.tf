variable "AccountId" {
    description = "Find your account ID at https://accounts.cloud.databricks.com"
    type = string
    default = "963144b7-b3c7-4b1d-8394-d5e86611edc4"
  
}

variable "Username" {
    description = "Your case-sensitive Databricks account email address."
    type = string
    default = "sasixil602@themesw.com"
  
}

variable "Password" {
    description = "This is the password you set for your Databricks account."
    type = string
    default = "nw1sg6yk12019Q2!"
  
}

variable "WorkspaceName" {
    description = "Human-readable name for this workspace."
    type = string
    default = "data-engineering"
  
}

variable "AWSRegion" {
    description = "AWS Region where the workspace will be created."
    type = string
    default = "ap-northeast-1"
  
}

variable "IAMRole" {
    description = "Specify a unique cross-account IAM role name. For naming rules, see https://docs.aws.amazon.com/IAM/latest/APIReference/API_CreateRole.html."
    type = string
    default = "databricks-iam-role"
  
}


variable "BucketName" {
    description = "Specify a unique name for the S3 bucket where Databricks will store metadata for your workspace. Use only alphanumeric characters. For naming rules, see https://docs.aws.amazon.com/AmazonS3/latest/dev/BucketRestrictions.html."
    type = string
    default = "databricks-s3-root-bucket"
  
}

    