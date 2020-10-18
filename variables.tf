variable "consumer_name" {
  type        = string
  description = "Name of the consumer application"
}

variable "provider_name" {
  type        = string
  description = "Name of the provider application"
}

variable "github_owner" {
  type        = string
  description = "Owner of the GitHub repositories"
}

variable "enabled" {
  type        = bool
  description = "Whether to enable the webhook"
  default     = true
}
