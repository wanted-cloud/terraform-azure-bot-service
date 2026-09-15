resource "azurerm_bot_connection" "this" {
  for_each = { for connection in var.connections : connection.name => connection }

  name                = each.value.name
  bot_name            = azurerm_bot_service_azure_bot.this.name
  resource_group_name = azurerm_bot_service_azure_bot.this.resource_group_name
  location            = azurerm_bot_service_azure_bot.this.location

  service_provider_name = each.value.service_provider_name
  client_id             = each.value.client_id
  client_secret         = each.value.client_secret
  scopes                = each.value.scopes
  parameters            = each.value.parameters

  timeouts {
    create = try(
      local.metadata.resource_timeouts["azurerm_bot_connection"]["create"],
      local.metadata.resource_timeouts["default"]["create"]
    )
    read = try(
      local.metadata.resource_timeouts["azurerm_bot_connection"]["read"],
      local.metadata.resource_timeouts["default"]["read"]
    )
    update = try(
      local.metadata.resource_timeouts["azurerm_bot_connection"]["update"],
      local.metadata.resource_timeouts["default"]["update"]
    )
    delete = try(
      local.metadata.resource_timeouts["azurerm_bot_connection"]["delete"],
      local.metadata.resource_timeouts["default"]["delete"]
    )
  }
}
