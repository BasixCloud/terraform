resource "vault_auth_backend" "approle" {
  type = "approle"
}

resource "vault_auth_backend" "kubernetes" {
  type = "kubernetes"
}

# resource "vault_kubernetes_auth_backend_config" "kubernetes" {
#   backend = vault_auth_backend.kubernetes.id
#   kubernetes_host = data.tfe_outputs.cluster.values.host
# }

resource "vault_token" "terraform_automation" {
  
}
