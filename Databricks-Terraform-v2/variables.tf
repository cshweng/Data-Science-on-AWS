variable "databricks_account_username" {
    description = "Your case-sensitive Databricks account email address."
    type = string
    default = "sasixil602@themesw.com"
  
}

variable "databricks_account_password"{
    description = "This is the password you set for your Databricks account."
    type = string
    default = "nw1sg6yk12019Q2!"
  
}

variable "databricks_account_id"  {
    description = "Find your account ID at https://accounts.cloud.databricks.com"
    type = string
    default = "963144b7-b3c7-4b1d-8394-d5e86611edc4"
  
}


variable "tags" {
  default ="Databricks"
}

variable "cidr_block" {
  default = "10.4.0.0/16"
}

variable "region" {
  default = "ap-northeast-1"
}

resource "random_string" "naming" {
  special = false
  upper   = false
  length  = 6
}

locals {
  prefix = "databricks"
}
