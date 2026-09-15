output "id" {
  description = "Resource ID of the Azure Bot Service, use it as a scope for role assignments."
  value       = azurerm_bot_service_azure_bot.this.id
}

output "name" {
  description = "Name of the Azure Bot Service."
  value       = azurerm_bot_service_azure_bot.this.name
}

output "display_name" {
  description = "User facing name of the Azure Bot Service."
  value       = azurerm_bot_service_azure_bot.this.display_name
}

output "resource_group_name" {
  description = "Resource group the Azure Bot Service lives in."
  value       = azurerm_bot_service_azure_bot.this.resource_group_name
}

output "location" {
  description = "Location of the Azure Bot Service, channels are always created in the same location."
  value       = azurerm_bot_service_azure_bot.this.location
}

output "endpoint" {
  description = "Messaging endpoint the Bot Framework delivers activities to."
  value       = azurerm_bot_service_azure_bot.this.endpoint
}

output "microsoft_app_id" {
  description = "Client ID of the Entra ID application backing the bot identity."
  value       = azurerm_bot_service_azure_bot.this.microsoft_app_id
}

output "channels" {
  description = "Map of the created channels to their resource IDs, keyed by channel name. Channels which were not requested are not present in the map."
  value = {
    for channel, id in {
      alexa              = try(azurerm_bot_channel_alexa.this[0].id, null)
      direct_line_speech = try(azurerm_bot_channel_direct_line_speech.this[0].id, null)
      directline         = try(azurerm_bot_channel_directline.this[0].id, null)
      email              = try(azurerm_bot_channel_email.this[0].id, null)
      facebook           = try(azurerm_bot_channel_facebook.this[0].id, null)
      line               = try(azurerm_bot_channel_line.this[0].id, null)
      ms_teams           = try(azurerm_bot_channel_ms_teams.this[0].id, null)
      slack              = try(azurerm_bot_channel_slack.this[0].id, null)
      sms                = try(azurerm_bot_channel_sms.this[0].id, null)
      web_chat           = try(azurerm_bot_channel_web_chat.this[0].id, null)
    } : channel => id if id != null
  }
}

output "directline_sites" {
  description = "Direct Line sites keyed by site name together with their generated secrets, these are the credentials a client uses to open a Direct Line conversation with the bot."
  sensitive   = true
  value = {
    for site in try(azurerm_bot_channel_directline.this[0].site, []) : site.name => {
      id   = site.id
      key  = site.key
      key2 = site.key2
    }
  }
}

output "directline_extension_keys" {
  description = "Direct Line App Service extension keys of the Direct Line channel, null when the channel is not created."
  sensitive   = true
  value = {
    extension_key_1 = try(azurerm_bot_channel_directline.this[0].extension_key_1, null)
    extension_key_2 = try(azurerm_bot_channel_directline.this[0].extension_key_2, null)
  }
}

output "connections" {
  description = "Map of the created OAuth connection settings to their resource IDs, keyed by connection name."
  value       = { for name, connection in azurerm_bot_connection.this : name => connection.id }
}
