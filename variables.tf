variable "consumer" {
  description = <<EOF
The webhook configuration for the consumer application.

(Required) name - The name of the consumer application. This must be the name of the application as defined in the contract.
(Required) repository - The name of the consumer repository in the form "organisation/repository". Used to create the GitHub status check.
EOF
  type = object({
    name       = string
    repository = string
  })
}

variable "producers" {
  description = <<EOF
List of webhook configurations for each provider application. The variable is
named `producers` to avoid conflict with the Terraform meta-argument
`providers`.

(Required) name - The name of the provider application. This must be the name of the application as defined in the contract.
(Required) repository - The name of the provider repository in the form "organisation/repository". Used to create the GitHub status check.

(Optional) enabled - Whether the provider webhooks are enabled. Defaults to true. If false, both the `contract_published` and `contract_verified` webhooks will be disabled.
(Optional) team_id - The ID of the team to assign to the webhooks. A different team can be assigned to each consumer/provider pair.
EOF
  type = list(object({
    enabled    = optional(bool, true)
    name       = string
    repository = string
    team_id    = optional(string)
  }))
  nullable = false
  validation {
    condition     = length(var.producers) != 0
    error_message = "At least one producer must be configured."
  }
}
