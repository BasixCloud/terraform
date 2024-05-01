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

module "cert_manager_crds" {
  source    = "../../../modules/remote-manifest"
  url       = format("https://github.com/cert-manager/cert-manager/releases/download/v%s/cert-manager.crds.yaml", var.cert_manager_version)
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
  version    = var.cert_manager_version
  namespace  = kubernetes_namespace.cert_manager.id

  set {
    name  = "replicaCount"
    value = 2
  }

  set {
    name  = "podDisruptionBudget.enabled"
    value = "false"
  }
}

# cert-manager speicifc resource manifests
resource "kubernetes_manifest" "manifests" {
  for_each = fileset(path.module, "manifests/*.yaml")
  manifest = yamldecode(templatefile("${path.module}/${each.key}", {
    email = var.email
  }))

  depends_on = [module.cert_manager_crds]
}
