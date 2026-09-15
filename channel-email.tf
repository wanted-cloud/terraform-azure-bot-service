resource "azurerm_bot_channel_email" "this" {
  count = var.email_channel != null ? 1 : 0

  bot_name            = azurerm_bot_service_azure_bot.this.name
  resource_group_name = azurerm_bot_service_azure_bot.this.resource_group_name
  location            = azurerm_bot_service_azure_bot.this.location

  email_address  = var.email_channel.email_address
  email_password = var.email_channel.email_password
  magic_code     = var.email_channel.magic_code

  timeouts {
    create = try(
      local.metadata.resource_timeouts["azurerm_bot_channel_email"]["create"],
      local.metadata.resource_timeouts["default"]["create"]
    )
    read = try(
      local.metadata.resource_timeouts["azurerm_bot_channel_email"]["read"],
      local.metadata.resource_timeouts["default"]["read"]
    )
    update = try(
      local.metadata.resource_timeouts["azurerm_bot_channel_email"]["update"],
      local.metadata.resource_timeouts["default"]["update"]
    )
    delete = try(
      local.metadata.resource_timeouts["azurerm_bot_channel_email"]["delete"],
      local.metadata.resource_timeouts["default"]["delete"]
    )
  }
}
