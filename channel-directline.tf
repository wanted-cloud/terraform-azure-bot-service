resource "azurerm_bot_channel_directline" "this" {
  count = var.directline_channel != null ? 1 : 0

  bot_name            = azurerm_bot_service_azure_bot.this.name
  resource_group_name = azurerm_bot_service_azure_bot.this.resource_group_name
  location            = azurerm_bot_service_azure_bot.this.location

  dynamic "site" {
    for_each = { for site in var.directline_channel.sites : site.name => site }

    content {
      name                            = site.value.name
      enabled                         = site.value.enabled
      endpoint_parameters_enabled     = site.value.endpoint_parameters_enabled
      enhanced_authentication_enabled = site.value.enhanced_authentication_enabled
      storage_enabled                 = site.value.storage_enabled
      trusted_origins                 = site.value.trusted_origins
      user_upload_enabled             = site.value.user_upload_enabled
      v1_allowed                      = site.value.v1_allowed
      v3_allowed                      = site.value.v3_allowed
    }
  }

  timeouts {
    create = try(
      local.metadata.resource_timeouts["azurerm_bot_channel_directline"]["create"],
      local.metadata.resource_timeouts["default"]["create"]
    )
    read = try(
      local.metadata.resource_timeouts["azurerm_bot_channel_directline"]["read"],
      local.metadata.resource_timeouts["default"]["read"]
    )
    update = try(
      local.metadata.resource_timeouts["azurerm_bot_channel_directline"]["update"],
      local.metadata.resource_timeouts["default"]["update"]
    )
    delete = try(
      local.metadata.resource_timeouts["azurerm_bot_channel_directline"]["delete"],
      local.metadata.resource_timeouts["default"]["delete"]
    )
  }
}
