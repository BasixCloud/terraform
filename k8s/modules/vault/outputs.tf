output "namespace_id" {
  value = kubernetes_namespace.namespace.id
}

output "token_reviewer_jwt" {
  value = kubernetes_secret.vault_auth_token.binary_data.token
  sensitive = true
}
