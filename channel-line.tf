resource "azurerm_bot_channel_line" "this" {
  count = var.line_channel != null ? 1 : 0

  bot_name            = azurerm_bot_service_azure_bot.this.name
  resource_group_name = azurerm_bot_service_azure_bot.this.resource_group_name
  location            = azurerm_bot_service_azure_bot.this.location

  dynamic "line_channel" {
    for_each = var.line_channel.channels

    content {
      access_token = line_channel.value.access_token
      secret       = line_channel.value.secret
    }
  }

  timeouts {
    create = try(
      local.metadata.resource_timeouts["azurerm_bot_channel_line"]["create"],
      local.metadata.resource_timeouts["default"]["create"]
    )
    read = try(
      local.metadata.resource_timeouts["azurerm_bot_channel_line"]["read"],
      local.metadata.resource_timeouts["default"]["read"]
    )
    update = try(
      local.metadata.resource_timeouts["azurerm_bot_channel_line"]["update"],
      local.metadata.resource_timeouts["default"]["update"]
    )
    delete = try(
      local.metadata.resource_timeouts["azurerm_bot_channel_line"]["delete"],
      local.metadata.resource_timeouts["default"]["delete"]
    )
  }
}
