# #############################################################################
# Variables
# #############################################################################

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which the resources will be created."
}

variable "application_type" {
  type        = string
  description = "The type of application that will be monitored by the Application Insights resource. Valid values are `ios`, `java`, `mobilecenter`, `node`, `other`, `phone`, `store`, `web`, or `windows`."
  validation {
    condition = can(regex("^(ios|java|mobilecenter|node|other|phone|store|web|windows)$", var.application_type))
    error_message = "The application type must be either 'ios', 'java', 'mobilecenter', 'node', 'other', 'phone', 'store', 'web', or 'windows'."
  }
}

variable "daily_data_capp_in_gb" {
  type        = number
  default     = 100
  description = "The daily data volume cap in GB. The default is 100."
}

variable "daily_data-cap_notifications_disabled" {
  type        = bool
  default     = false
  description = "Specifies whether the Application Insights resource should send daily data volume cap notifications. The default is false."
}

variable "retention_in_days" {
  type        = number
  default     = 90
  description = "The retention period for the logs in days. Possible values are 30, 60, 90, 120, 180, 270, 365, 550, or 730. The default is 90 days."
  validation {
    condition = can(index([30, 60, 90, 120, 180, 270, 365, 550, 730], var.retention_in_days))
    error_message = "The retention period must be one of 30, 60, 90, 120, 180, 270, 365, 550, or 730."
  }
}

variable "sampling_percentage" {
  type        = number
  default     = 100
  description = "The percentage of telemetry data to sample. The default is 100."
}

variable "disable_ip_masking" {
  type        = bool
  default     = false
  description = "By default the real client IP is masked as `0.0.0.0` in the logs. Use this argument to disable masking and log the real client IP. The default is false."
}

variable "workspace_id" {
  type        = string
  default     = null
  description = "The ID of the Log Analytics Workspace to which the Application Insights resource should be linked."
}

variable "local_authentication_disabled" {
  type        = bool
  default     = false
  description = "Specifies whether the Application Insights resource should enforce authentication using Azure AD. The default is false."
}

variable "internet_ingestion_enabled" {
  type        = bool
  default     = true
  description = "Specifies whether the Application Insights resource should allow direct internet ingestion. The default is true."
}

variable "internet_query_enabled" {
  type        = bool
  default     = true
  description = "Specifies whether the Application Insights resource should allow direct internet queries. The default is true."
}

variable "force_customer_storage_for_profiler" {
  type        = bool
  default     = false
  description = "Specifies whether the Application Insights resource should force customer storage for profiler. The default is false."
}