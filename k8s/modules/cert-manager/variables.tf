variable "cert_manager_version" {
  description = "cert-manager version to deploy, without the v prefix!"
  type        = string
  default     = "1.14.5"
}

variable "email" {
  type = string
}
