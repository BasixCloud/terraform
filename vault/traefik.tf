resource "vault_policy" "cloudflare" {
  name = "cloudflare"

  policy = <<EOT
path "kv2/cloudflare" {
  capabilities = ["read"]
}
EOT
}

resource "vault_kubernetes_auth_backend_role" "traefik" {
  role_name = "traefik"
  bound_service_account_names = []
  bound_service_account_namespaces = []
  token_policies = [vault_policy.cloudflare.id]
}
