output "contract_published_webhook_uuid" {
  value = pact_webhook.contract_published.uuid
}

output "contract_verified_webhook_uuid" {
  value = pact_webhook.contract_verified.uuid
}
