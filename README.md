<!-- BEGIN_TF_DOCS -->
# wanted-cloud/terraform-azure-bot-service

Simple Terraform building block wrapping Azure Bot Service (Azure Bot) together with its messaging channels and OAuth connections.

## Table of contents

- [Requirements](#requirements)
- [Providers](#providers)
- [Variables](#inputs)
- [Outputs](#outputs)
- [Resources](#resources)
- [Usage](#usage)
- [Contributing](#contributing)

## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (>= 1.9)

- <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) (>= 4.20.0)

## Providers

The following providers are used by this module:

- <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) (5.5.0)

## Required Inputs

The following input variables are required:

### <a name="input_microsoft_app_id"></a> [microsoft\_app\_id](#input\_microsoft\_app\_id)

Description: Client ID of the Entra ID application backing the bot identity. Changing this forces a new resource to be created.

Type: `string`

### <a name="input_name"></a> [name](#input\_name)

Description: Name of the Azure Bot Service, this is the immutable resource name (see display\_name for the user facing one).

Type: `string`

### <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name)

Description: Name of the resource group in which the Azure Bot Service will be created.

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_alexa_channel"></a> [alexa\_channel](#input\_alexa\_channel)

Description: Alexa channel of the bot, set to create it.

Type:

```hcl
object({
    skill_id = string
  })
```

Default: `null`

### <a name="input_cmk_key_vault_key_url"></a> [cmk\_key\_vault\_key\_url](#input\_cmk\_key\_vault\_key\_url)

Description: Key Vault key URL used to encrypt the bot with a customer managed key. The vault needs soft delete and purge protection enabled and the Bot Service CMEK Prod service principal needs the Key Vault Crypto Service Encryption User role on it.

Type: `string`

Default: `""`

### <a name="input_connections"></a> [connections](#input\_connections)

Description: OAuth connection settings of the bot, used by the bot to obtain tokens on behalf of the user from an identity provider.

Type:

```hcl
list(object({
    name                  = string
    service_provider_name = string
    client_id             = string
    client_secret         = string
    scopes                = optional(string)
    parameters            = optional(map(string), {})
  }))
```

Default: `[]`

### <a name="input_developer_app_insights_api_key"></a> [developer\_app\_insights\_api\_key](#input\_developer\_app\_insights\_api\_key)

Description: Application Insights API key used by the Bot Framework developer portal to read analytics.

Type: `string`

Default: `""`

### <a name="input_developer_app_insights_application_id"></a> [developer\_app\_insights\_application\_id](#input\_developer\_app\_insights\_application\_id)

Description: Application ID of the Application Insights instance associated with the bot.

Type: `string`

Default: `""`

### <a name="input_developer_app_insights_key"></a> [developer\_app\_insights\_key](#input\_developer\_app\_insights\_key)

Description: Instrumentation key of the Application Insights instance associated with the bot.

Type: `string`

Default: `""`

### <a name="input_direct_line_speech_channel"></a> [direct\_line\_speech\_channel](#input\_direct\_line\_speech\_channel)

Description: Direct Line Speech channel of the bot, set to create it. Wires the bot to a Cognitive Services (Speech) account.

Type:

```hcl
object({
    cognitive_account_id         = optional(string)
    cognitive_service_access_key = optional(string)
    cognitive_service_location   = optional(string)
    custom_speech_model_id       = optional(string)
    custom_voice_deployment_id   = optional(string)
  })
```

Default: `null`

### <a name="input_directline_channel"></a> [directline\_channel](#input\_directline\_channel)

Description: Direct Line channel of the bot, set to create it. Each site gets its own pair of secrets, exposed through the directline\_sites output.

Type:

```hcl
object({
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
```

Default: `null`

### <a name="input_display_name"></a> [display\_name](#input\_display\_name)

Description: User facing name of the bot, defaults to the value of name when not set.

Type: `string`

Default: `""`

### <a name="input_email_channel"></a> [email\_channel](#input\_email\_channel)

Description: Email channel of the bot, set to create it. Office 365 mailboxes authenticate with magic\_code instead of email\_password.

Type:

```hcl
object({
    email_address  = string
    email_password = optional(string)
    magic_code     = optional(string)
  })
```

Default: `null`

### <a name="input_endpoint"></a> [endpoint](#input\_endpoint)

Description: HTTPS messaging endpoint the Bot Framework delivers activities to, typically https://<your-service>/api/messages.

Type: `string`

Default: `""`

### <a name="input_facebook_channel"></a> [facebook\_channel](#input\_facebook\_channel)

Description: Facebook Messenger channel of the bot, set to create it.

Type:

```hcl
object({
    application_id     = string
    application_secret = string
    pages = list(object({
      id           = string
      access_token = string
    }))
  })
```

Default: `null`

### <a name="input_icon_url"></a> [icon\_url](#input\_icon\_url)

Description: Icon URL of the bot, defaults to the Bot Framework default icon when not set.

Type: `string`

Default: `""`

### <a name="input_line_channel"></a> [line\_channel](#input\_line\_channel)

Description: LINE channel of the bot, set to create it.

Type:

```hcl
object({
    channels = list(object({
      access_token = string
      secret       = string
    }))
  })
```

Default: `null`

### <a name="input_local_authentication_enabled"></a> [local\_authentication\_enabled](#input\_local\_authentication\_enabled)

Description: Whether local (key based) authentication is enabled for the bot.

Type: `bool`

Default: `true`

### <a name="input_location"></a> [location](#input\_location)

Description: Location of the Azure Bot Service and all its channels. Azure Bot Service is a global resource, only a handful of regions (global, westeurope, westus, centralindia, uaenorth ...) are accepted.

Type: `string`

Default: `"global"`

### <a name="input_luis_app_ids"></a> [luis\_app\_ids](#input\_luis\_app\_ids)

Description: List of LUIS application IDs to associate with the bot.

Type: `list(string)`

Default: `[]`

### <a name="input_luis_key"></a> [luis\_key](#input\_luis\_key)

Description: LUIS key to associate with the bot.

Type: `string`

Default: `""`

### <a name="input_metadata"></a> [metadata](#input\_metadata)

Description: Metadata definitions for the module, this is optional construct allowing override of the module defaults defintions of validation expressions, error messages, resource timeouts and default tags.

Type:

```hcl
object({
    resource_timeouts = optional(
      map(
        object({
          create = optional(string, "30m")
          read   = optional(string, "5m")
          update = optional(string, "30m")
          delete = optional(string, "30m")
        })
      ), {}
    )
    tags                     = optional(map(string), {})
    validator_error_messages = optional(map(string), {})
    validator_expressions    = optional(map(string), {})
  })
```

Default: `{}`

### <a name="input_microsoft_app_msi_id"></a> [microsoft\_app\_msi\_id](#input\_microsoft\_app\_msi\_id)

Description: Resource ID of the user assigned managed identity backing the bot, required for the UserAssignedMSI application type. Changing this forces a new resource to be created.

Type: `string`

Default: `""`

### <a name="input_microsoft_app_tenant_id"></a> [microsoft\_app\_tenant\_id](#input\_microsoft\_app\_tenant\_id)

Description: Tenant ID of the Microsoft App backing the bot, required for SingleTenant and UserAssignedMSI application types. Changing this forces a new resource to be created.

Type: `string`

Default: `""`

### <a name="input_microsoft_app_type"></a> [microsoft\_app\_type](#input\_microsoft\_app\_type)

Description: Type of the Microsoft App backing the bot, possible values are MultiTenant, SingleTenant and UserAssignedMSI. Creation of MultiTenant bots is no longer supported by Azure. Changing this forces a new resource to be created.

Type: `string`

Default: `"SingleTenant"`

### <a name="input_ms_teams_channel"></a> [ms\_teams\_channel](#input\_ms\_teams\_channel)

Description: Microsoft Teams channel of the bot, set to an empty object to create it with defaults.

Type:

```hcl
object({
    calling_enabled        = optional(bool)
    calling_web_hook       = optional(string)
    deployment_environment = optional(string)
  })
```

Default: `null`

### <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled)

Description: Whether the bot is reachable over the public network.

Type: `bool`

Default: `true`

### <a name="input_sku"></a> [sku](#input\_sku)

Description: SKU of the Azure Bot Service, either F0 (free) or S1 (standard). Changing this forces a new resource to be created.

Type: `string`

Default: `"F0"`

### <a name="input_slack_channel"></a> [slack\_channel](#input\_slack\_channel)

Description: Slack channel of the bot, set to create it.

Type:

```hcl
object({
    client_id          = string
    client_secret      = string
    verification_token = string
    landing_page_url   = optional(string)
    signing_secret     = optional(string)
  })
```

Default: `null`

### <a name="input_sms_channel"></a> [sms\_channel](#input\_sms\_channel)

Description: SMS (Twilio) channel of the bot, set to create it.

Type:

```hcl
object({
    phone_number         = string
    account_security_id  = string
    authentication_token = string
  })
```

Default: `null`

### <a name="input_streaming_endpoint_enabled"></a> [streaming\_endpoint\_enabled](#input\_streaming\_endpoint\_enabled)

Description: Whether the streaming endpoint is enabled for the bot.

Type: `bool`

Default: `false`

### <a name="input_tags"></a> [tags](#input\_tags)

Description: Tags to apply to the Azure Bot Service, merged on top of the module default tags.

Type: `map(string)`

Default: `{}`

### <a name="input_web_chat_channel"></a> [web\_chat\_channel](#input\_web\_chat\_channel)

Description: Web Chat channel of the bot, set to create it.

Type:

```hcl
object({
    sites = list(object({
      name                        = string
      endpoint_parameters_enabled = optional(bool)
      storage_enabled             = optional(bool)
      user_upload_enabled         = optional(bool)
    }))
  })
```

Default: `null`

## Outputs

The following outputs are exported:

### <a name="output_channels"></a> [channels](#output\_channels)

Description: Map of the created channels to their resource IDs, keyed by channel name. Channels which were not requested are not present in the map.

### <a name="output_connections"></a> [connections](#output\_connections)

Description: Map of the created OAuth connection settings to their resource IDs, keyed by connection name.

### <a name="output_directline_extension_keys"></a> [directline\_extension\_keys](#output\_directline\_extension\_keys)

Description: Direct Line App Service extension keys of the Direct Line channel, null when the channel is not created.

### <a name="output_directline_sites"></a> [directline\_sites](#output\_directline\_sites)

Description: Direct Line sites keyed by site name together with their generated secrets, these are the credentials a client uses to open a Direct Line conversation with the bot.

### <a name="output_display_name"></a> [display\_name](#output\_display\_name)

Description: User facing name of the Azure Bot Service.

### <a name="output_endpoint"></a> [endpoint](#output\_endpoint)

Description: Messaging endpoint the Bot Framework delivers activities to.

### <a name="output_id"></a> [id](#output\_id)

Description: Resource ID of the Azure Bot Service, use it as a scope for role assignments.

### <a name="output_location"></a> [location](#output\_location)

Description: Location of the Azure Bot Service, channels are always created in the same location.

### <a name="output_microsoft_app_id"></a> [microsoft\_app\_id](#output\_microsoft\_app\_id)

Description: Client ID of the Entra ID application backing the bot identity.

### <a name="output_name"></a> [name](#output\_name)

Description: Name of the Azure Bot Service.

### <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name)

Description: Resource group the Azure Bot Service lives in.

## Resources

The following resources are used by this module:

- [azurerm_bot_channel_alexa.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/bot_channel_alexa) (resource)
- [azurerm_bot_channel_direct_line_speech.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/bot_channel_direct_line_speech) (resource)
- [azurerm_bot_channel_directline.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/bot_channel_directline) (resource)
- [azurerm_bot_channel_email.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/bot_channel_email) (resource)
- [azurerm_bot_channel_facebook.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/bot_channel_facebook) (resource)
- [azurerm_bot_channel_line.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/bot_channel_line) (resource)
- [azurerm_bot_channel_ms_teams.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/bot_channel_ms_teams) (resource)
- [azurerm_bot_channel_slack.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/bot_channel_slack) (resource)
- [azurerm_bot_channel_sms.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/bot_channel_sms) (resource)
- [azurerm_bot_channel_web_chat.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/bot_channel_web_chat) (resource)
- [azurerm_bot_connection.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/bot_connection) (resource)
- [azurerm_bot_service_azure_bot.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/bot_service_azure_bot) (resource)
- [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) (data source)

## Usage

> For more detailed examples navigate to `examples` folder of this repository.

Module was also published via Terraform Registry and can be used as a module from the registry.

```hcl
module "example" {
  source  = "wanted-cloud/bot-service/azure"
  version = "x.y.z"
}
```

### Basic usage example

The minimal usage for the module is as follows:

```hcl
module "example" {
  source = "../.."

  name                = "example-bot"
  resource_group_name = "example-rg"

  microsoft_app_id        = "00000000-0000-0000-0000-000000000000"
  microsoft_app_type      = "SingleTenant"
  microsoft_app_tenant_id = "00000000-0000-0000-0000-000000000000"

  endpoint = "https://example.com/api/messages"
}
```

### Bot with channels

Channels are optional objects, setting one creates the channel, leaving it at its `null` default does not:

```hcl
module "example" {
  source = "../.."

  name                = "example-bot"
  resource_group_name = "example-rg"

  microsoft_app_id        = "00000000-0000-0000-0000-000000000000"
  microsoft_app_type      = "SingleTenant"
  microsoft_app_tenant_id = "00000000-0000-0000-0000-000000000000"

  endpoint = "https://example.com/api/messages"

  # Empty object creates the channel with its defaults.
  ms_teams_channel = {}

  web_chat_channel = {
    sites = [{
      name            = "default"
      storage_enabled = true
    }]
  }

  # Each Direct Line site gets its own secrets, read them from the
  # sensitive `directline_sites` output.
  directline_channel = {
    sites = [{
      name       = "default"
      enabled    = true
      v3_allowed = true
    }]
  }

  slack_channel = {
    client_id          = "example-client-id"
    client_secret      = "example-client-secret"
    verification_token = "example-verification-token"
  }
}
```

### Bot with OAuth connections

```hcl
module "example" {
  source = "../.."

  name                = "example-bot"
  resource_group_name = "example-rg"

  microsoft_app_id        = "00000000-0000-0000-0000-000000000000"
  microsoft_app_type      = "SingleTenant"
  microsoft_app_tenant_id = "00000000-0000-0000-0000-000000000000"

  endpoint = "https://example.com/api/messages"

  # OAuth connection settings the bot uses to obtain tokens on behalf of the user.
  connections = [{
    name                  = "graph"
    service_provider_name = "Aadv2"
    client_id             = "00000000-0000-0000-0000-000000000000"
    client_secret         = "example-client-secret"
    scopes                = "User.Read"

    parameters = {
      tenantID = "00000000-0000-0000-0000-000000000000"
    }
  }]
}
```
## Contributing

_Contributions are welcomed and must follow [Code of Conduct](https://github.com/wanted-cloud/.github?tab=coc-ov-file) and common [Contributions guidelines](https://github.com/wanted-cloud/.github/blob/main/docs/CONTRIBUTING.md)._

> If you'd like to report security issue please follow [security guidelines](https://github.com/wanted-cloud/.github?tab=security-ov-file).
---
<sup><sub>_2025 &copy; All rights reserved - WANTED.solutions s.r.o._</sub></sup>
<!-- END_TF_DOCS -->