variable "toolchain_id" {
}

variable "sm_resource_group" {
}

variable "sm_location" {
}

variable "sm_name" {
}

variable "sm_secret_group" {
}

variable "sm_instance_guid" {
  type        = string
  description = "GUID of the Secrets Manager service instance in IBM Cloud"
}

#variable "key_protect_service_auth" {
#  type        = string
#  description = "Authorization Permission for the Key Protect Toolchain Service Instance in IBM Cloud"
#  default     = "[\"Viewer\", \"ReaderPlus\"]"
#}

variable "slack_api_token" {
  type        = string
  description = "API Token for Slack Channel"
  default     = ""
}

variable "slack_channel_name" {
  type        = string
  description = "Name of Slack Channel"
  default     = ""
}

variable "slack_user_name" {
  type        = string
  description = "Name of Slack User"
  default     = ""
}

variable "authorization_policy_creation" {
  type        = string
  description = "Disable Toolchain Service to Secrets Manager Service auhorization policy creation"
  default     = ""
}

variable "link_to_doi_toolchain" {
  description = "Enable a link to a DevOpsInsights instance in another toolchain, true or false"
  type        = bool
  default     = false
}

variable "doi_toolchain_id" {
  type = string
  description = "DevOpsInsights Toolchain ID to link to"
  default = ""  
}
