
variable "databricks_account_username" {
    type = string 
}

variable "databricks_account_password"{
    type = string 
}

variable "databricks_account_id"  {
    type = string
}

variable "tags" {
    type = any
}

variable "cidr_block" {
    type = string
}

variable "region" {
    type = string
}
variable "prefix" {
  type = string
}

variable "workspace_name" {
  type = string
}

locals {
  prefix = "e2"
  }

