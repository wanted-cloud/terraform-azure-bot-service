variable "name" {
  description = "Name of the Azure Bot Service, this is the immutable resource name (see display_name for the user facing one)."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group in which the Azure Bot Service will be created."
  type        = string
}

variable "location" {
  description = "Location of the Azure Bot Service and all its channels. Azure Bot Service is a global resource, only a handful of regions (global, westeurope, westus, centralindia, uaenorth ...) are accepted."
  type        = string
  default     = "global"
}

variable "microsoft_app_id" {
  description = "Client ID of the Entra ID application backing the bot identity. Changing this forces a new resource to be created."
  type        = string
}

variable "microsoft_app_type" {
  description = "Type of the Microsoft App backing the bot, possible values are MultiTenant, SingleTenant and UserAssignedMSI. Creation of MultiTenant bots is no longer supported by Azure. Changing this forces a new resource to be created."
  type        = string
  default     = "SingleTenant"

  validation {
    condition     = can(regex(local.metadata.validator_expressions["microsoft_app_type"], var.microsoft_app_type))
    error_message = local.metadata.validator_error_messages["microsoft_app_type"]
  }
}

variable "microsoft_app_tenant_id" {
  description = "Tenant ID of the Microsoft App backing the bot, required for SingleTenant and UserAssignedMSI application types. Changing this forces a new resource to be created."
  type        = string
  default     = ""
}

variable "microsoft_app_msi_id" {
  description = "Resource ID of the user assigned managed identity backing the bot, required for the UserAssignedMSI application type. Changing this forces a new resource to be created."
  type        = string
  default     = ""
}

variable "sku" {
  description = "SKU of the Azure Bot Service, either F0 (free) or S1 (standard). Changing this forces a new resource to be created."
  type        = string
  default     = "F0"

  validation {
    condition     = can(regex(local.metadata.validator_expressions["sku"], var.sku))
    error_message = local.metadata.validator_error_messages["sku"]
  }
}

variable "display_name" {
  description = "User facing name of the bot, defaults to the value of name when not set."
  type        = string
  default     = ""
}

variable "endpoint" {
  description = "HTTPS messaging endpoint the Bot Framework delivers activities to, typically https://<your-service>/api/messages."
  type        = string
  default     = ""
}

variable "icon_url" {
  description = "Icon URL of the bot, defaults to the Bot Framework default icon when not set."
  type        = string
  default     = ""
}

variable "developer_app_insights_api_key" {
  description = "Application Insights API key used by the Bot Framework developer portal to read analytics."
  type        = string
  default     = ""
  sensitive   = true
}

variable "developer_app_insights_application_id" {
  description = "Application ID of the Application Insights instance associated with the bot."
  type        = string
  default     = ""
}

variable "developer_app_insights_key" {
  description = "Instrumentation key of the Application Insights instance associated with the bot."
  type        = string
  default     = ""
}

variable "luis_app_ids" {
  description = "List of LUIS application IDs to associate with the bot."
  type        = list(string)
  default     = []
}

variable "luis_key" {
  description = "LUIS key to associate with the bot."
  type        = string
  default     = ""
  sensitive   = true
}

variable "cmk_key_vault_key_url" {
  description = "Key Vault key URL used to encrypt the bot with a customer managed key. The vault needs soft delete and purge protection enabled and the Bot Service CMEK Prod service principal needs the Key Vault Crypto Service Encryption User role on it."
  type        = string
  default     = ""
}

variable "local_authentication_enabled" {
  description = "Whether local (key based) authentication is enabled for the bot."
  type        = bool
  default     = true
}

variable "public_network_access_enabled" {
  description = "Whether the bot is reachable over the public network."
  type        = bool
  default     = true
}

variable "streaming_endpoint_enabled" {
  description = "Whether the streaming endpoint is enabled for the bot."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags to apply to the Azure Bot Service, merged on top of the module default tags."
  type        = map(string)
  default     = {}
}

/*
 * Channels - each channel can exist at most once per bot, therefore they are modelled as
 * optional objects, leaving a channel at its null default means the channel is not created.
 */

variable "alexa_channel" {
  description = "Alexa channel of the bot, set to create it."
  type = object({
    skill_id = string
  })
  default = null
}

variable "direct_line_speech_channel" {
  description = "Direct Line Speech channel of the bot, set to create it. Wires the bot to a Cognitive Services (Speech) account."
  type = object({
    cognitive_account_id         = optional(string)
    cognitive_service_access_key = optional(string)
    cognitive_service_location   = optional(string)
    custom_speech_model_id       = optional(string)
    custom_voice_deployment_id   = optional(string)
  })
  default = null
}

variable "directline_channel" {
  description = "Direct Line channel of the bot, set to create it. Each site gets its own pair of secrets, exposed through the directline_sites output."
  type = object({
    sites = list(object({
      name                            = string
      enabled                         = optional(bool)
      endpoint_parameters_enabled     = optional(bool)
      enhanced_authentication_enabled = optional(bool)
      storage_enabled                 = optional(bool)
      trusted_origins                 = optional(set(string))
      user_upload_enabled             = optional(bool)
      v1_allowed                      = optional(bool)
      v3_allowed                      = optional(bool)
    }))
  })
  default = null
}

variable "email_channel" {
  description = "Email channel of the bot, set to create it. Office 365 mailboxes authenticate with magic_code instead of email_password."
  type = object({
    email_address  = string
    email_password = optional(string)
    magic_code     = optional(string)
  })
  default = null
}

variable "facebook_channel" {
  description = "Facebook Messenger channel of the bot, set to create it."
  type = object({
    application_id     = string
    application_secret = string
    pages = list(object({
      id           = string
      access_token = string
    }))
  })
  default = null
}

variable "line_channel" {
  description = "LINE channel of the bot, set to create it."
  type = object({
    channels = list(object({
      access_token = string
      secret       = string
    }))
  })
  default = null
}

variable "ms_teams_channel" {
  description = "Microsoft Teams channel of the bot, set to an empty object to create it with defaults."
  type = object({
    calling_enabled        = optional(bool)
    calling_web_hook       = optional(string)
    deployment_environment = optional(string)
  })
  default = null
}

variable "slack_channel" {
  description = "Slack channel of the bot, set to create it."
  type = object({
    client_id          = string
    client_secret      = string
    verification_token = string
    landing_page_url   = optional(string)
    signing_secret     = optional(string)
  })
  default = null
}

variable "sms_channel" {
  description = "SMS (Twilio) channel of the bot, set to create it."
  type = object({
    phone_number         = string
    account_security_id  = string
    authentication_token = string
  })
  default = null
}

variable "web_chat_channel" {
  description = "Web Chat channel of the bot, set to create it."
  type = object({
    sites = list(object({
      name                        = string
      endpoint_parameters_enabled = optional(bool)
      storage_enabled             = optional(bool)
      user_upload_enabled         = optional(bool)
    }))
  })
  default = null
}

variable "connections" {
  description = "OAuth connection settings of the bot, used by the bot to obtain tokens on behalf of the user from an identity provider."
  type = list(object({
    name                  = string
    service_provider_name = string
    client_id             = string
    client_secret         = string
    scopes                = optional(string)
    parameters            = optional(map(string), {})
  }))
  default = []
}
