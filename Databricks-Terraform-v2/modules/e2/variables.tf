

variable "databricks_account_id"  {

    type = string
  
}


variable "region" {
  type = string
}

locals {
  prefix = "databricks"
}
