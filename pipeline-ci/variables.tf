variable "pipeline_id" {
}

variable "dev_resource_group" {
}

variable "app_name" {
}

variable "signing_key_secret_name" {
}

variable "cos_api_key_secret_name" {
}

variable "pipeline_ibmcloud_api_key_secret_name" {
}

variable "cluster_name" {
}

variable "cluster_namespace" {
}

variable "dev_region" {
}

variable "registry_namespace" {
}

variable "registry_region" {
}

variable "ibm_cloud_api" {
}

variable "ibm_cloud_api_key" {
}

variable "secret_tool" {
  type        = string
  description = "Used as part of secret references to point to the secret store tool integration"
}

variable "app_repo_url" {
}

variable "app_repo_branch" {
}

# variable "cos_api_key_secret_name" {
# }

variable "cos_bucket_name" {
}

variable "cos_endpoint" {
}

variable "pipeline_repo_url" {
}

variable "inventory_repo_url" {
}

variable "evidence_repo_url" {
}

variable "issues_repo_url" {
}

variable "inventory_repo" {
}

variable "evidence_repo" {
}

variable "issues_repo" {
}

variable "pipeline_config_repo" {
}

variable "pipeline_config_repo_existing_url" {
}

variable "pipeline_config_repo_branch" {
}

variable "pipeline_config_path" {
}

variable "pipeline_branch" {
  type        = string
  description = "The branch within pipeline definitions repository for Compliance CI Toolchain."
  default     = "open-v9"
}

variable "pipeline_path" {
  type        = string
  description = "The relative folder path within pipeline definitions repository containing tekton definitions for pipelines."
  default     = "definitions"
}

variable "ci_pipeline_max_concurrent_runs" {
  type        = number
  description = "The number of maximum concurrent runs to be supported by CI Pipeline"
  default     = 1
}

######## Deployment Strategy ##################

variable "deployment_target" {
}

######## Code Engine Vars #####################

variable "code_engine_project" {
}

variable "code_engine_region" {
}

variable "code_engine_resource_group" {
}

variable "code_engine_entity_type" {
}

variable "code_engine_build_strategy" {
}

variable "code_engine_source" {
}

variable "app_repo_provider_webhook_syntax" {
}
variable "compliance_base_image" {
  type        = string
  description = "Pipeline baseimage to run most of the built-in pipeline code"
  default     = ""
}
