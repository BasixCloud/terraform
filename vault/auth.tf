resource "vault_auth_backend" "approle" {
  type = "approle"
}

resource "vault_auth_backend" "kubernetes" {
  type = "kubernetes"
}

resource "vault_kubernetes_auth_backend_config" "kubernetes" {
  backend = vault_auth_backend.kubernetes.id
  kubernetes_host = data.tfe_outputs.cluster.values.host
  kubernetes_ca_cert = base64decode(data.tfe_outputs.cluster.values.cluster_ca_certificate)
  token_reviewer_jwt = data.tfe_outputs.kubernetes.values.token_reviewer_jwt
}

