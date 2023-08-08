# terraform-pact-contract

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

## Requirements

| Name | Version |
|------|---------|
| [terraform](https://www.terraform.io/) | >= 1.0 |

## Modules

No modules.
