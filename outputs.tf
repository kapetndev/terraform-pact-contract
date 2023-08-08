output "webhook_ids" {
  description = "The webhook IDs for each consumer/provider pair."
  value = {
    for name, p in local.providers : name => {
      "contract_published_webhook_id" : pact_webhook.contract_published[name].uuid,
      "contract_verified_webhook_id" : pact_webhook.contract_verified[name].uuid,
    }
  }
}
