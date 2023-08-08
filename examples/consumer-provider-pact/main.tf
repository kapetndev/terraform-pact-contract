module "my_contract" {
  source = "git::https://github.com/kapetndev/terraform-pact-contract.git?ref=v0.1.0"

  consumer = {
    name       = "my-consumer"
    repository = "https://github.com/kapetndev/my-consumer"
  }

  producers = [
    {
      name       = "my-provider"
      repository = "https://github.com/kapetndev/my-provider"
    },
  ]
}
