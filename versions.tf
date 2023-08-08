terraform {
  required_providers {
    pact = {
      source  = "pactflow/pact"
      version = ">= 0.9.1"
    }
  }
  required_version = ">= 1.0"
}
