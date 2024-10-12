# #############################################################################
# Outputs for the Application Insights resource
# #############################################################################

output "application_insights" {
  value = azurerm_application_insights.target
  description = "The managed Application Insights resource."
}

output "workspace_id" {
  value = local.workspace_id
  description = "The ID of the Log Analytics Workspace associated with the Application Insights resource."
}