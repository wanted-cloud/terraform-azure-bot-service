resource "azurerm_bot_channel_facebook" "this" {
  count = var.facebook_channel != null ? 1 : 0

  bot_name            = azurerm_bot_service_azure_bot.this.name
  resource_group_name = azurerm_bot_service_azure_bot.this.resource_group_name
  location            = azurerm_bot_service_azure_bot.this.location

  facebook_application_id     = var.facebook_channel.application_id
  facebook_application_secret = var.facebook_channel.application_secret

  dynamic "page" {
    for_each = { for page in var.facebook_channel.pages : page.id => page }

    content {
      id           = page.value.id
      access_token = page.value.access_token
    }
  }

  timeouts {
    create = try(
      local.metadata.resource_timeouts["azurerm_bot_channel_facebook"]["create"],
      local.metadata.resource_timeouts["default"]["create"]
    )
    read = try(
      local.metadata.resource_timeouts["azurerm_bot_channel_facebook"]["read"],
      local.metadata.resource_timeouts["default"]["read"]
    )
    update = try(
      local.metadata.resource_timeouts["azurerm_bot_channel_facebook"]["update"],
      local.metadata.resource_timeouts["default"]["update"]
    )
    delete = try(
      local.metadata.resource_timeouts["azurerm_bot_channel_facebook"]["delete"],
      local.metadata.resource_timeouts["default"]["delete"]
    )
  }
}
