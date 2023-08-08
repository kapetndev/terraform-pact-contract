locals {
  providers = {
    for p in var.providers : p.name => p
  }
}

resource "pact_webhook" "contract_published" {
  for_each    = local.providers
  description = "${var.consumer.name} contract published (${each.value.name})"
  enabled     = each.value.enabled
  team        = each.value.team_id

  events = [
    "contract_content_changed"
  ]

  request {
    url    = "https://api.github.com/repos/${each.value.repository}/dispatches"
    method = "POST"

    headers = {
      "Content-Type"  = "application/json"
      "Accept"        = "application/vnd.github.v3+json"
      "Authorization" = "token $${user.githubToken}"
    }

    body = <<-EOF
    {
      "event_type": "contract_published",
      "client_payload": {
        "consumer_labels": "$${pactbroker.consumerLabels}",
        "consumer_name": "$${pactbroker.consumerName}",
        "consumer_version_branch": "$${pactbroker.consumerVersionBranch}",
        "consumer_version_number": "$${pactbroker.consumerVersionNumber}",
        "consumer_version_tags": "$${pactbroker.consumerVersionTags}",
        "pact_url": "$${pactbroker.pactUrl}",
        "provider_name": "$${pactbroker.providerName}"
      }
    }
    EOF
  }

  webhook_consumer = {
    name = var.consumer.name
  }

  webhook_provider = {
    name = each.value.name
  }
}

resource "pact_webhook" "contract_verified" {
  for_each    = local.providers
  description = "${var.consumer.name} contract verified (${each.value.name})"
  enabled     = each.value.enabled
  team        = each.value.team_id

  events = [
    "provider_verification_published"
  ]

  request {
    url    = "https://api.github.com/repos/${var.consumer.repository}/statuses/$${pactbroker.consumerVersionNumber}"
    method = "POST"

    headers = {
      "Content-Type"  = "application/json"
      "Accept"        = "application/vnd.github.v3+json"
      "Authorization" = "token $${user.githubToken}"
    }

    body = <<-EOF
    {
      "context": "contract-verification/pactbroker",
      "description": "Contract verification state: $${pactbroker.githubVerificationStatus}",
      "state": "$${pactbroker.githubVerificationStatus}",
      "target_url": "$${pactbroker.verificationResultUrl}"
    }
    EOF
  }

  webhook_consumer = {
    name = var.consumer.name
  }

  webhook_provider = {
    name = each.value.name
  }
}
