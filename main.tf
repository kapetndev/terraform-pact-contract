resource "pact_webhook" "contract_published" {
  description = "${var.consumer_name} contract published"
  enabled     = var.enabled

  events = [
    "contract_content_changed"
  ]

  webhook_consumer = {
    name = var.consumer_name
  }

  webhook_provider = {
    name = var.provider_name
  }

  request {
    url    = "https://api.github.com/repos/${var.github_owner}/${var.provider_name}/dispatches"
    method = "POST"

    headers = {
      "Content-Type"  = "application/json"
      "Accept"        = "application/vnd.github.v3+json"
      "Authorization" = "token $${user.githubToken}"
    }

    body = <<EOF
{
  "event_type": "contract_published",
  "client_payload": {
    "consumer_name": "$${pactbroker.consumerName}",
    "provider_name": "$${pactbroker.providerName}",
    "consumer_version_number": "$${pactbroker.consumerVersionNumber}",
    "consumer_version_tags": "$${pactbroker.consumerVersionTags}",
    "pact_url": "$${pactbroker.pactUrl}"
  }
}
EOF
  }
}

resource "pact_webhook" "contract_verified" {
  description = "${var.consumer_name} contract verified"
  enabled     = var.enabled

  events = [
    "provider_verification_published"
  ]

  webhook_consumer = {
    name = var.consumer_name
  }

  webhook_provider = {
    name = var.provider_name
  }

  request {
    url    = "https://api.github.com/repos/${var.github_owner}/${var.consumer_name}/statuses/$${pactbroker.consumerVersionNumber}"
    method = "POST"

    headers = {
      "Content-Type"  = "application/json"
      "Accept"        = "application/vnd.github.v3+json"
      "Authorization" = "token $${user.githubToken}"
    }

    body = <<EOF
{
  "state": "$${pactbroker.githubVerificationStatus}",
  "target_url": "$${pactbroker.verificationResultUrl}",
  "description": "Contract verification state: $${pactbroker.githubVerificationStatus}",
  "context": "contract-verification/pactbroker"
}
EOF
  }
}
