resource "azurerm_bot_channel_web_chat" "this" {
  count = var.web_chat_channel != null ? 1 : 0

  bot_name            = azurerm_bot_service_azure_bot.this.name
  resource_group_name = azurerm_bot_service_azure_bot.this.resource_group_name
  location            = azurerm_bot_service_azure_bot.this.location

  dynamic "site" {
    for_each = { for site in var.web_chat_channel.sites : site.name => site }

    content {
      name                        = site.value.name
      endpoint_parameters_enabled = site.value.endpoint_parameters_enabled
      storage_enabled             = site.value.storage_enabled
      user_upload_enabled         = site.value.user_upload_enabled
    }
  }

  timeouts {
    create = try(
      local.metadata.resource_timeouts["azurerm_bot_channel_web_chat"]["create"],
      local.metadata.resource_timeouts["default"]["create"]
    )
    read = try(
      local.metadata.resource_timeouts["azurerm_bot_channel_web_chat"]["read"],
      local.metadata.resource_timeouts["default"]["read"]
    )
    update = try(
      local.metadata.resource_timeouts["azurerm_bot_channel_web_chat"]["update"],
      local.metadata.resource_timeouts["default"]["update"]
    )
    delete = try(
      local.metadata.resource_timeouts["azurerm_bot_channel_web_chat"]["delete"],
      local.metadata.resource_timeouts["default"]["delete"]
    )
  }
}
