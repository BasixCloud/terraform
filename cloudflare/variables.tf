variable "api_token" {
  description = "Cloudflare API key"
  type        = string
  sensitive   = true
}

variable "zone_id" {
  description = "Cloudflare Zone ID."
  type        = string
  sensitive   = true
}

