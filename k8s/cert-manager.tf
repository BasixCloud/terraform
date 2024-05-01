variable "cert_manager_version" {
  description = "cert-manager version to deploy."
  type        = string
  default     = "v1.14.5"
}

module "cert_manager_crds" {
  source = "../modules/remote-manifest"
  url =  format("https://github.com/cert-manager/cert-manager/releases/download/%s/cert-manager.crds.yaml", var.cert_manager_version)
  namespace = null # CRD definitions.
}

resource "kubernetes_namespace" "cert_manager" {
  metadata {
    name = "cert-manager"
  }
}

resource "helm_release" "cert_manager" {
  name       = "cert-manager"
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  version    = "1.14.5"
  namespace  = kubernetes_namespace.prometheus.id

  set {
    name = "replicaCount"
    value = 2
  }

  set {
    name  = "podDisruptionBudget.enabled"
    value = "false"
  }
}
