module "example" {
  source = "../.."

  name                = "example-bot"
  resource_group_name = "example-rg"

  microsoft_app_id        = "00000000-0000-0000-0000-000000000000"
  microsoft_app_type      = "SingleTenant"
  microsoft_app_tenant_id = "00000000-0000-0000-0000-000000000000"

  endpoint = "https://example.com/api/messages"
}
