# #############################################################################
# Outputs for the Application Insights resource
# #############################################################################

output "application_insights" {
  value = azurerm_application_insights.target
  description = "The managed Application Insights resource."
}