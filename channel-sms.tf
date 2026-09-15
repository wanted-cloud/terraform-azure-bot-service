resource "azurerm_bot_channel_sms" "this" {
  count = var.sms_channel != null ? 1 : 0

  bot_name            = azurerm_bot_service_azure_bot.this.name
  resource_group_name = azurerm_bot_service_azure_bot.this.resource_group_name
  location            = azurerm_bot_service_azure_bot.this.location

  phone_number                    = var.sms_channel.phone_number
  sms_channel_account_security_id = var.sms_channel.account_security_id
  sms_channel_auth_token          = var.sms_channel.authentication_token

  timeouts {
    create = try(
      local.metadata.resource_timeouts["azurerm_bot_channel_sms"]["create"],
      local.metadata.resource_timeouts["default"]["create"]
    )
    read = try(
      local.metadata.resource_timeouts["azurerm_bot_channel_sms"]["read"],
      local.metadata.resource_timeouts["default"]["read"]
    )
    update = try(
      local.metadata.resource_timeouts["azurerm_bot_channel_sms"]["update"],
      local.metadata.resource_timeouts["default"]["update"]
    )
    delete = try(
      local.metadata.resource_timeouts["azurerm_bot_channel_sms"]["delete"],
      local.metadata.resource_timeouts["default"]["delete"]
    )
  }
}
