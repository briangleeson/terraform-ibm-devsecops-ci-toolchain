data "ibm_resource_group" "resource_group" {
  name = var.toolchain_resource_group
}

resource "ibm_cd_toolchain" "toolchain_instance" {
  name              = var.toolchain_name
  description       = var.toolchain_description
  resource_group_id = data.ibm_resource_group.resource_group.id
}

module "repositories" {
  source = "./repositories"

  toolchain_id                   = ibm_cd_toolchain.toolchain_instance.id
  toolchain_region               = var.toolchain_region
  toolchain_crn                  = ibm_cd_toolchain.toolchain_instance.crn
  app_repo_existing_url          = var.app_repo_existing_url
  app_repo_existing_branch       = var.app_repo_existing_branch
  app_repo_existing_git_provider = var.app_repo_existing_git_provider
  app_repo_existing_git_id       = var.app_repo_existing_git_id
  app_repo_clone_from_url        = var.app_repo_clone_from_url
  app_repo_clone_from_branch     = var.app_repo_clone_from_branch
  repositories_prefix            = var.repositories_prefix
  app_repo_clone_to_git_provider = var.app_repo_clone_to_git_provider
  app_repo_clone_to_git_id       = var.app_repo_clone_to_git_id
  app_group                      = var.app_group
  issues_group                   = var.issues_group
  evidence_group                 = var.evidence_group
  inventory_group                = var.inventory_group
}

resource "ibm_cd_toolchain_tool_pipeline" "ci_pipeline" {
  toolchain_id = ibm_cd_toolchain.toolchain_instance.id
  parameters {
    name = "ci-pipeline"
  }
}

module "pipeline-ci" {
  source     = "./pipeline-ci"
  depends_on = [module.repositories, module.integrations, module.services]

  ibm_cloud_api      = var.ibm_cloud_api
  ibm_cloud_api_key  = var.ibm_cloud_api_key
  pipeline_id        = split("/", ibm_cd_toolchain_tool_pipeline.ci_pipeline.id)[1]
  app_name           = var.app_name
  cluster_name       = var.cluster_name
  cluster_namespace  = var.cluster_namespace
  dev_region         = var.dev_region
  dev_resource_group = var.dev_resource_group
  registry_namespace = var.registry_namespace
  registry_region    = var.registry_region
  app_repo_url       = module.repositories.app_repo_url
  app_repo_branch    = module.repositories.app_repo_branch
  config_repo_branch = module.repositories.config_repo_branch
  pipeline_repo_url  = module.repositories.pipeline_repo_url
  evidence_repo_url  = module.repositories.evidence_repo_url
  inventory_repo_url = module.repositories.inventory_repo_url
  issues_repo_url    = module.repositories.issues_repo_url
  secret_tool        = module.integrations.secret_tool
  cos_bucket_name    = var.cos_bucket_name
  # cos_api_key              = var.cos_api_key
  cos_endpoint                     = var.cos_endpoint
  deployment_target                = var.deployment_target
  code_engine_project              = var.code_engine_project
  code_engine_region               = var.code_engine_region
  code_engine_resource_group       = var.code_engine_resource_group
  code_engine_entity_type          = var.code_engine_entity_type
  code_engine_build_strategy       = var.code_engine_build_strategy
  code_engine_source               = var.code_engine_source
  app_repo_provider_webhook_syntax = module.repositories.app_repo_provider_webhook_syntax
  compliance_base_image            = var.compliance_base_image
}

resource "ibm_cd_toolchain_tool_pipeline" "pr_pipeline" {
  toolchain_id = ibm_cd_toolchain.toolchain_instance.id
  parameters {
    name = "pr-pipeline"
  }
}

module "pipeline-pr" {
  source     = "./pipeline-pr"
  depends_on = [module.repositories, module.integrations, module.services]

  ibm_cloud_api                    = var.ibm_cloud_api
  ibm_cloud_api_key                = var.ibm_cloud_api_key
  pipeline_id                      = split("/", ibm_cd_toolchain_tool_pipeline.pr_pipeline.id)[1]
  app_name                         = var.app_name
  app_repo_url                     = module.repositories.app_repo_url
  app_repo_branch                  = module.repositories.app_repo_branch
  config_repo_branch               = module.repositories.config_repo_branch
  pipeline_repo_url                = module.repositories.pipeline_repo_url
  secret_tool                      = module.integrations.secret_tool
  app_repo_provider_webhook_syntax = module.repositories.app_repo_provider_webhook_syntax
  compliance_base_image            = var.compliance_base_image
}

module "integrations" {
  source     = "./integrations"
  depends_on = [module.repositories, module.services]

  sm_location                   = var.sm_location
  toolchain_id                  = ibm_cd_toolchain.toolchain_instance.id
  sm_resource_group             = var.sm_resource_group
  sm_name                       = var.sm_name
  sm_instance_guid              = module.services.sm_instance_guid
  sm_secret_group               = var.sm_secret_group
  slack_channel_name            = var.slack_channel_name
  slack_api_token               = var.slack_api_token
  slack_user_name               = var.slack_user_name
  authorization_policy_creation = var.authorization_policy_creation
  link_to_doi_toolchain         = var.link_to_doi_toolchain
  doi_toolchain_id              = var.doi_toolchain_id
}

module "services" {
  source = "./services"

  sm_name            = var.sm_name
  sm_location        = var.sm_location
  sm_resource_group  = var.sm_resource_group
  cluster_name       = var.cluster_name
  cluster_namespace  = var.cluster_namespace
  registry_namespace = var.registry_namespace
  registry_region    = var.registry_region
}

output "toolchain_id" {
  value = ibm_cd_toolchain.toolchain_instance.id
}

output "secrets_manager_instance_id" {
  value = module.services.sm_instance_guid
}

output "ci_pipeline_id" {
  value = module.pipeline-ci.pipeline_id
}

output "pr_pipeline_id" {
  value = module.pipeline-pr.pipeline_id
}

output "secret_tool" {
  value = module.integrations.secret_tool
}

output "inventory_repo_url" {
  value       = module.repositories.inventory_repo_url
  description = "The inventory repository instance url, with details of which artifact has been built and will be deployed"
}

output "evidence_repo_url" {
  value       = module.repositories.evidence_repo_url
  description = "The evidence repository instance url, where evidence of the builds and scans are stored, ready for any compliance audit"
}

output "issues_repo_url" {
  value       = module.repositories.issues_repo_url
  description = "The incident issues repository instance url, where issues are created when vulnerabilities and CVEs are detected"
}

output "pipeline_repo_url" {
  value       = module.repositories.pipeline_repo_url
  description = "This repository url contains the tekton definitions for compliance pipelines"
}

output "app_repo_url" {
  value       = module.repositories.app_repo_url
  description = "The app repository instance url containing an application that can be built and deployed with the reference DevSecOps toolchain templates."
}

# output "test_output" {
#   value = module.repositories.test_output
# }
