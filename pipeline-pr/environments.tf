resource "ibm_cd_tekton_pipeline_property" "pr_pipeline_ibmcloud_api_key" {
  name           = "ibmcloud-api-key"
  type           = "secure"
  value          = format("{vault::%s.${var.pipeline_ibmcloud_api_key_secret_name}}", var.secret_tool)
  pipeline_id    = ibm_cd_tekton_pipeline.pr_pipeline_instance.pipeline_id
}

resource "ibm_cd_tekton_pipeline_property" "pr_pipeline_pipeline_config" {
  name           = "pipeline-config"
  type           = "text"
  value          = var.pipeline_config_path
  pipeline_id    = ibm_cd_tekton_pipeline.pr_pipeline_instance.pipeline_id
}

resource "ibm_cd_tekton_pipeline_property" "pr_pipeline_pipeline_config_branch" {
  name           = "pipeline-config-branch"
  type           = "text"
  value          = var.pipeline_config_repo_branch
  pipeline_id    = ibm_cd_tekton_pipeline.pr_pipeline_instance.pipeline_id
}

resource "ibm_cd_tekton_pipeline_property" "pr_pipeline_pipeline_config_repo" {
  count          = (var.pipeline_config_repo_existing_url == "") && (var.pipeline_config_repo_clone_from_url == "") ? 0 : 1 
  name           = "pipeline-config-repo"
  type           = "integration"
  value          = try(var.pipeline_config_repo[0].tool_id, "")
  path           = "parameters.repo_url"
  pipeline_id    = ibm_cd_tekton_pipeline.pr_pipeline_instance.pipeline_id
}

resource "ibm_cd_tekton_pipeline_property" "pr_pipeline_pipeline_config_repo_default" {
  count          = (var.pipeline_config_repo_existing_url == "") && (var.pipeline_config_repo_clone_from_url == "") ? 1 : 0 
  name           = "pipeline-config-repo"
  type           = "text"
  value          = try(var.pipeline_config_repo[0].tool_id, "")
  pipeline_id    = ibm_cd_tekton_pipeline.pr_pipeline_instance.pipeline_id
}

resource "ibm_cd_tekton_pipeline_property" "pr_pipeline_pipeline_debug" {
  name           = "pipeline-debug"
  type           = "single_select"
  enum           = ["0", "1"]
  value          = var.pipeline_debug
  pipeline_id    = ibm_cd_tekton_pipeline.pr_pipeline_instance.pipeline_id
}

resource "ibm_cd_tekton_pipeline_property" "pr_pipeline_slack_notifications" {
  name           = "slack-notifications"
  type           = "text"
  value          = var.slack_notifications
  pipeline_id    = ibm_cd_tekton_pipeline.pr_pipeline_instance.pipeline_id
}

resource "ibm_cd_tekton_pipeline_property" "pr_pipeline_ibm_cloud_api" {
  name           = "ibmcloud-api"
  type           = "text"
  value          = var.ibmcloud_api
  pipeline_id    = ibm_cd_tekton_pipeline.pr_pipeline_instance.pipeline_id
}

resource "ibm_cd_tekton_pipeline_property" "pr_pipeline_git-token" {
  name           = "git-token"
  type           = "secure"
  value          = ""
  pipeline_id    = ibm_cd_tekton_pipeline.pr_pipeline_instance.pipeline_id
}
resource "ibm_cd_tekton_pipeline_property" "pr_pipeline_base_image" {
  count          = (var.compliance_base_image == "") ? 0:1
  name           = "compliance-baseimage"
  type           = "text"
  value          = var.compliance_base_image
  pipeline_id    = ibm_cd_tekton_pipeline.pr_pipeline_instance.pipeline_id
}
