variable "host" {
  description = "A host of Vault instance."
  type = string
}

variable "token" {
  description = "A Vault token."
  type = string
  sensitive = true
}
