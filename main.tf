# #############################################################################
# Create an Application Insights resource
# #############################################################################

module "naming" {
  source  = "TaleLearnCode/naming/azurerm"
  version = "0.0.4-pre"

  resource_type  = "application_insights"
  name_prefix    = var.name_prefix
  name_suffix    = var.name_suffix
  srv_comp_abbr  = var.srv_comp_abbr
  custom_name    = var.custom_name
  location       = var.location
  environment    = var.environment
}

resource "azurerm_application_insights" "target" {
  name                = module.naming.resource_name
  location            = var.location
  resource_group_name = var.resource_group_name
  application_type    = var.application_type

  workspace_id = var.workspace_id != null ? var.workspace_id : null
 
  daily_data_cap_in_gb                  = var.daily_data_capp_in_gb
  daily_data_cap_notifications_disabled = var.daily_data-cap_notifications_disabled
  retention_in_days                     = var.retention_in_days
  sampling_percentage                   = var.sampling_percentage

  disable_ip_masking = var.disable_ip_masking

  local_authentication_disabled       = var.local_authentication_disabled
  internet_ingestion_enabled          = var.internet_ingestion_enabled
  internet_query_enabled              = var.internet_ingestion_enabled
  force_customer_storage_for_profiler = var.force_customer_storage_for_profiler
  
  tags = var.tags
}