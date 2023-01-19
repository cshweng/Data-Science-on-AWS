// e2 
module "e2" {
  source                       = "./modules/e2"
  databricks_account_username  = var.databricks_account_username
  databricks_account_password  = var.databricks_account_password
  databricks_account_id        = var.databricks_account_id
  tags                         = var.tags
  cidr_block                   = var.cidr_block
  region                       = var.region
  prefix                       = var.prefix
  workspace_name               = var.workspace_name
}

#module "create_workspace"{
#  source                       = "./modules/create_workspace"
#  workspace_name               = var.workspace_name
#  databricks_account_username  = var.databricks_account_username
#  databricks_account_password  = var.databricks_account_password
#  databricks_account_id        = var.databricks_account_id
#  tags                         = var.tags
#}

  #module "unity_catalog" {
  #  source                       =  "./modules/unity_catalog"
  #  databricks_account_username  = var.databricks_account_username
  #  databricks_account_password  = var.databricks_account_password
  #  databricks_account_id        = var.databricks_account_id
  #  databricks_workspace_url     =  
  #  aws_account_id               = 
  #  tags                         = var.tags
  #  region                       = var.region
  #  databricks_workspace_ids     = 
  #  databricks_users             = 
  #  databricks_metastore_admins  = 
  #  unity_admin_group            = 
  #}

