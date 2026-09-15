locals {
  // Here you can define module metadata 
  definitions = {
    tags = { ManagedBy = "Terraform" }

    validator_expressions = {
      microsoft_app_type = "^(MultiTenant|SingleTenant|UserAssignedMSI)$"
      sku                = "^(F0|S1)$"
    }

    validator_error_messages = {
      microsoft_app_type = "The microsoft_app_type must be one of MultiTenant, SingleTenant or UserAssignedMSI."
      sku                = "The sku must be either F0 (free) or S1 (standard)."
    }
  }
}
