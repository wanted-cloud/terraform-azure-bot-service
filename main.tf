/*
 * # wanted-cloud/terraform-azure-bot-service
 * 
 * Simple Terraform building block wrapping Azure Bot Service (Azure Bot) together with its messaging channels and OAuth connections.
 */

resource "azurerm_bot_service_azure_bot" "this" {
  name                = var.name
  resource_group_name = data.azurerm_resource_group.this.name
  location            = var.location

  microsoft_app_id        = var.microsoft_app_id
  microsoft_app_type      = var.microsoft_app_type
  microsoft_app_tenant_id = var.microsoft_app_tenant_id != "" ? var.microsoft_app_tenant_id : null
  microsoft_app_msi_id    = var.microsoft_app_msi_id != "" ? var.microsoft_app_msi_id : null

  sku          = var.sku
  display_name = var.display_name != "" ? var.display_name : null
  endpoint     = var.endpoint != "" ? var.endpoint : null
  icon_url     = var.icon_url != "" ? var.icon_url : null

  developer_app_insights_api_key        = var.developer_app_insights_api_key != "" ? var.developer_app_insights_api_key : null
  developer_app_insights_application_id = var.developer_app_insights_application_id != "" ? var.developer_app_insights_application_id : null
  developer_app_insights_key            = var.developer_app_insights_key != "" ? var.developer_app_insights_key : null

  luis_app_ids = var.luis_app_ids
  luis_key     = var.luis_key != "" ? var.luis_key : null

  cmk_key_vault_key_url         = var.cmk_key_vault_key_url != "" ? var.cmk_key_vault_key_url : null
  local_authentication_enabled  = var.local_authentication_enabled
  public_network_access_enabled = var.public_network_access_enabled
  streaming_endpoint_enabled    = var.streaming_endpoint_enabled

  tags = merge(local.metadata.tags, var.tags)

  timeouts {
    create = try(
      local.metadata.resource_timeouts["azurerm_bot_service_azure_bot"]["create"],
      local.metadata.resource_timeouts["default"]["create"]
    )
    read = try(
      local.metadata.resource_timeouts["azurerm_bot_service_azure_bot"]["read"],
      local.metadata.resource_timeouts["default"]["read"]
    )
    update = try(
      local.metadata.resource_timeouts["azurerm_bot_service_azure_bot"]["update"],
      local.metadata.resource_timeouts["default"]["update"]
    )
    delete = try(
      local.metadata.resource_timeouts["azurerm_bot_service_azure_bot"]["delete"],
      local.metadata.resource_timeouts["default"]["delete"]
    )
  }
}
