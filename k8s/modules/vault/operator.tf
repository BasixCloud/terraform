resource "kubernetes_namespace" "vault_secrets_operator" {
  metadata {
    name = "vault-secrets-operator-system"
  }
}

resource "kubernetes_service_account" "vault_secrets_operator" {
  metadata {
    name      = "operator"
    namespace = kubernetes_namespace.vault_secrets_operator.id
  }
}

resource "helm_release" "vault_secrets_operator" {
  name       = "vault-secrets-operator"
  repository = "https://helm.releases.hashicorp.com"
  chart      = "vault"
  version    = "0.28.0"
  namespace  = kubernetes_namespace.vault_secrets_operator.id

  values = [
    file("${path.module}/operator-values.yaml")
  ]
}

resource "kubernetes_manifest" "vault_static_auth" {
  depends_on = [ helm_release.vault ]
  manifest = file("${path.module}/vault-static-auth.yaml")
}

