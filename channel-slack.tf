resource "azurerm_bot_channel_slack" "this" {
  count = var.slack_channel != null ? 1 : 0

  bot_name            = azurerm_bot_service_azure_bot.this.name
  resource_group_name = azurerm_bot_service_azure_bot.this.resource_group_name
  location            = azurerm_bot_service_azure_bot.this.location

  client_id          = var.slack_channel.client_id
  client_secret      = var.slack_channel.client_secret
  verification_token = var.slack_channel.verification_token
  landing_page_url   = var.slack_channel.landing_page_url
  signing_secret     = var.slack_channel.signing_secret

  timeouts {
    create = try(
      local.metadata.resource_timeouts["azurerm_bot_channel_slack"]["create"],
      local.metadata.resource_timeouts["default"]["create"]
    )
    read = try(
      local.metadata.resource_timeouts["azurerm_bot_channel_slack"]["read"],
      local.metadata.resource_timeouts["default"]["read"]
    )
    update = try(
      local.metadata.resource_timeouts["azurerm_bot_channel_slack"]["update"],
      local.metadata.resource_timeouts["default"]["update"]
    )
    delete = try(
      local.metadata.resource_timeouts["azurerm_bot_channel_slack"]["delete"],
      local.metadata.resource_timeouts["default"]["delete"]
    )
  }
}
