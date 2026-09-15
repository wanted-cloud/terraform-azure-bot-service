resource "azurerm_bot_channel_direct_line_speech" "this" {
  count = var.direct_line_speech_channel != null ? 1 : 0

  bot_name            = azurerm_bot_service_azure_bot.this.name
  resource_group_name = azurerm_bot_service_azure_bot.this.resource_group_name
  location            = azurerm_bot_service_azure_bot.this.location

  cognitive_account_id         = var.direct_line_speech_channel.cognitive_account_id
  cognitive_service_access_key = var.direct_line_speech_channel.cognitive_service_access_key
  cognitive_service_location   = var.direct_line_speech_channel.cognitive_service_location
  custom_speech_model_id       = var.direct_line_speech_channel.custom_speech_model_id
  custom_voice_deployment_id   = var.direct_line_speech_channel.custom_voice_deployment_id

  timeouts {
    create = try(
      local.metadata.resource_timeouts["azurerm_bot_channel_direct_line_speech"]["create"],
      local.metadata.resource_timeouts["default"]["create"]
    )
    read = try(
      local.metadata.resource_timeouts["azurerm_bot_channel_direct_line_speech"]["read"],
      local.metadata.resource_timeouts["default"]["read"]
    )
    update = try(
      local.metadata.resource_timeouts["azurerm_bot_channel_direct_line_speech"]["update"],
      local.metadata.resource_timeouts["default"]["update"]
    )
    delete = try(
      local.metadata.resource_timeouts["azurerm_bot_channel_direct_line_speech"]["delete"],
      local.metadata.resource_timeouts["default"]["delete"]
    )
  }
}
