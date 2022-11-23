variable "pipeline_id" {
}

variable "dev_resource_group" {
}

variable "app_name" {
}

variable "app_image_name" {
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

variable "app_repo" {
}

# variable "cos_api_key" {
# }

variable "cos_bucket_name" {
}

variable "cos_endpoint" {
}

variable "pipeline_repo" {
    type        = string
    description = "The repository url containing pipeline definitions for Compliance CI Toolchain."
}

variable "inventory_repo" {
}

variable "evidence_repo" {
}

variable "issues_repo" {  
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