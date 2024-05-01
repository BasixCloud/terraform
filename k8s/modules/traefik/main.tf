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
    name = "traefik"
  }
}

resource "kubernetes_service_account" "traefik" {
  metadata {
    name = "traefik"
    namespace = kubernetes_namespace.namespace.id
  }
}

resource "helm_release" "traefik" {
  name       = "traefik"
  repository = "https://traefik.github.io/charts"
  chart      = "traefik"
  version    = "27.0.2"
  namespace  = kubernetes_namespace.namespace.id

  values = [
    file("${path.module}/values.yaml")
  ]

  set {
    name = "serviceAccount.name"
    value = kubernetes_service_account.traefik.metadata[0].name
  }
}
