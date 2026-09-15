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
