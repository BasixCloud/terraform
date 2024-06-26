resource "vault_policy" "cloudflare" {
  name = "cloudflare"

  policy = <<EOT
path "kv2/data/cloudflare" {
  capabilities = ["read", "list"]
}
EOT
}

resource "vault_kubernetes_auth_backend_role" "traefik" {
  role_name = "traefik"
  bound_service_account_names = ["traefik"]
  bound_service_account_namespaces = ["traefik"]
  token_policies = [vault_policy.cloudflare.id]
}
