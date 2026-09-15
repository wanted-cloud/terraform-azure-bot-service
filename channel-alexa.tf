resource "azurerm_bot_channel_alexa" "this" {
  count = var.alexa_channel != null ? 1 : 0

  bot_name            = azurerm_bot_service_azure_bot.this.name
  resource_group_name = azurerm_bot_service_azure_bot.this.resource_group_name
  location            = azurerm_bot_service_azure_bot.this.location

  skill_id = var.alexa_channel.skill_id

  timeouts {
    create = try(
      local.metadata.resource_timeouts["azurerm_bot_channel_alexa"]["create"],
      local.metadata.resource_timeouts["default"]["create"]
    )
    read = try(
      local.metadata.resource_timeouts["azurerm_bot_channel_alexa"]["read"],
      local.metadata.resource_timeouts["default"]["read"]
    )
    update = try(
      local.metadata.resource_timeouts["azurerm_bot_channel_alexa"]["update"],
      local.metadata.resource_timeouts["default"]["update"]
    )
    delete = try(
      local.metadata.resource_timeouts["azurerm_bot_channel_alexa"]["delete"],
      local.metadata.resource_timeouts["default"]["delete"]
    )
  }
}
