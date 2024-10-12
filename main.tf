# #############################################################################
# Create an Application Insights resource
# #############################################################################

# -----------------------------------------------------------------------------
# Log Analytics Workspace
# -----------------------------------------------------------------------------

module "log_analytics_workspace" {
  count   = var.create_workspace ? 1 : 0
  source  = "TaleLearnCode/log_analytics_workspace/azurerm"
  version = "0.0.1"
  providers = {
    azurerm = azurerm
  }

  srv_comp_abbr       = var.srv_comp_abbr
  location            = var.location
  environment         = var.environment
  resource_group_name = module.resource_group.resource_name
  identity_type       = "SystemAssigned"
}

locals {
  workspace_id = var.create_workspace && length(module.log_analytics_workspace.workspace) > 0 ? amodule.log_analytics_workspace.workspace[0].id : (var.workspace_id != "" ? var.workspace_id : null)
}

# -----------------------------------------------------------------------------
# Application Insights
# -----------------------------------------------------------------------------

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

  dynamic "workspace_id" {
    for_each = local.workspace_id != null ? toset(local.workspace_id) : []
    content {
      workspace_id = local.workspace_id
    }    
  }
  
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