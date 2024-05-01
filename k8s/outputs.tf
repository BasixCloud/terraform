output "argocd_initial_admin_secret" {
  value = data.kubernetes_secret.argocd_initial_admin_secret.data
  sensitive = true
}

output "token_reviewer_jwt" {
  value = module.vault.token_reviewer_jwt
  sensitive = true
}

output "traefik_public_ip" {
  value = data.kubernetes_service.traefik_loadbalancer.status[0].loadBalancer.ingress[0].ip
}
