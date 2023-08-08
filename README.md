# terraform-pact-contract ![policy](https://github.com/kapetndev/terraform-pact-contract/workflows/policy/badge.svg)

Contract testing is a software testing methodology that verifies software
components behave as defined by a contract between them. Unlike using expensive
and brittle integration tests, contract testing decouples the two (or more) ends
of the interaction, testing them separately and reporting the results to
a central [broker](https://pactflow.io/).

Coordinating the testing of each component may require asynchronous
communications to ensure verification happens after the contract has been
created/updated by the consumer. This module creates multiple webhooks, enabling
both a consumer to invoke verification tests by the provider CI pipeline, and
for those verification results to trigger a success/failure within the consumer
build.

**Note**: This module works only with GitHub Actions `repository_dispatch`
workflows.

## Usage

See the [examples](examples) directory for working examples for reference:

```hcl
module "my_contract" {
  source = "git::https://github.com/kapetndev/terraform-pact-contract.git?ref=v0.1.0"

  consumer = {
    name       = "my-consumer"
    repository = "https://github.com/kapetndev/my-consumer"
  }

  providers = [
    {
      name       = "my-provider"
      repository = "https://github.com/kapetndev/my-provider"
    },
  ]
}
```

## Examples

- [consumer-provider-pact](examples/consumer-provider-pact) - Create webhooks
  for a single consumer and provider pact.

## Requirements

| Name | Version |
|------|---------|
| [terraform](https://www.terraform.io/) | >= 1.0 |

## Providers

| Name | Version |
|------|---------|
| [pact](https://registry.terraform.io/providers/pactflow/pact/latest) | >= 0.9.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [`pact_webhook.contract_published`](https://registry.terraform.io/providers/pactflow/pact/latest/docs/resources/webhook) | resource |
| [`pact_webhook.contract_verified`](https://registry.terraform.io/providers/pactflow/pact/latest/docs/resources/webhook) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `consumer` | The webhook configuration for the consumer application | `object{...}` | | yes |
| `consumer.name` | The name of the consumer application. This must be the name of the application as defined in the contract | `string` | | yes |
| `consumer.repository` | The name of the consumer repository. Used to create the GitHub status check | `string` | | yes |
| `providers` | List of webhook configurations for each provider application | `list(object{...})` | | yes |
| `providers[*].name` | The name of the provider application. This must be the name of the application as defined in the contract | `string` | | yes |
| `providers[*].repository` | The name of the provider repository. Used to create the GitHub status check | `string` | | yes |
| `providers[*].enabled` | Whether the provider webhooks are enabled. If false, both the `contract_published` and `contract_verified` webhooks will be disabled | `bool` | `true` | no |
| `providers[*].team_id` | The ID of the team to assign to the webhooks. A different team can be assigned to each consumer/provider pair | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| `webhook_ids[*]` | The webhook IDs for each consumer/provider pair |
| `webhook_ids[*|.contract_published_webhook_id` | The contract published webhook ID |
| `webhook_ids[*].contract_verified_webhook_id` | The contract verified webhook ID |
