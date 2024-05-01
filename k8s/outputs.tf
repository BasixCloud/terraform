output "argocd_initial_admin_secret" {
  value = data.kubernetes_secret.argocd_initial_admin_secret.data
  sensitive = true
}

output "token_reviewer_jwt" {
  value = module.vault.token_reviewer_jwt
  sensitive = true
}

