terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.29.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.13.1"
    }
  }
}

resource "kubernetes_namespace" "namespace" {
  metadata {
    name = "vault"
  }
}

resource "helm_release" "vault" {
  name       = "vault"
  repository = "https://helm.releases.hashicorp.com"
  chart      = "vault"
  version    = "0.28.0"
  namespace  = kubernetes_namespace.namespace.id

  values = [
    file("${path.module}/values.yaml")
  ]
}

resource "kubernetes_service" "tempoary_vault_access" {
  metadata {
    namespace = kubernetes_namespace.namespace.id
    name = "vault-access-svc"
  }
  spec {
    type = "LoadBalancer"
    selector = {
      "app.kubernetes.io/instance" = "vault"
      "app.kubernetes.io/name"     = "vault"
      component                    = "server"
    }
    port {
      name        = "http"
      port        = 8200
      protocol    = "TCP"
      target_port = 8200
    }
  }
  depends_on = [helm_release.vault]
}

