resource "azurerm_bot_channel_ms_teams" "this" {
  count = var.ms_teams_channel != null ? 1 : 0

  bot_name            = azurerm_bot_service_azure_bot.this.name
  resource_group_name = azurerm_bot_service_azure_bot.this.resource_group_name
  location            = azurerm_bot_service_azure_bot.this.location

  calling_enabled        = var.ms_teams_channel.calling_enabled
  calling_web_hook       = var.ms_teams_channel.calling_web_hook
  deployment_environment = var.ms_teams_channel.deployment_environment

  timeouts {
    create = try(
      local.metadata.resource_timeouts["azurerm_bot_channel_ms_teams"]["create"],
      local.metadata.resource_timeouts["default"]["create"]
    )
    read = try(
      local.metadata.resource_timeouts["azurerm_bot_channel_ms_teams"]["read"],
      local.metadata.resource_timeouts["default"]["read"]
    )
    update = try(
      local.metadata.resource_timeouts["azurerm_bot_channel_ms_teams"]["update"],
      local.metadata.resource_timeouts["default"]["update"]
    )
    delete = try(
      local.metadata.resource_timeouts["azurerm_bot_channel_ms_teams"]["delete"],
      local.metadata.resource_timeouts["default"]["delete"]
    )
  }
}
