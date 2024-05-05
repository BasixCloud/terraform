resource "vault_transit_secret_backend_key" "vso_client_cache" {
  backend = vault_mount.transit.path
  name = "vso-client-cache"
}

resource "vault_policy" "vso_policy" {
   name = "auth-policy-operator"

  policy = <<EOT
path "${vault_mount.transit.path}/encrypt/${vault_transit_secret_backend_key.vso_client_cache.name}" {
   capabilities = ["create", "update"]
}
path "${vault_mount.transit.path}/decrypt/${vault_transit_secret_backend_key.vso_client_cache.name}" {
   capabilities = ["create", "update"]
}
EOT
}

resource "vault_kubernetes_auth_backend_role" "vso_kubernetes_role" {
  role_name = "auth-role-operator"
  bound_service_account_names = ["operator"]
  bound_service_account_namespaces = ["vault-secrets-operator-system"]

  audience = "vault"
  token_policies = [vault_policy.vso_policy.name, vault_policy.cloudflare.name]
}
