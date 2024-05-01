variable "argocd_version" {
  description = "Argo CD version to deploy."
  type        = string
  default     = "v2.10.8"
}

module "argocd" {
  source = "../modules/remote-manifest"
  url =  format("https://raw.githubusercontent.com/argoproj/argo-cd/%s/manifests/install.yaml", var.argocd_version)
  namespace = "argocd"
}

moved {
  from = kubectl_manifest.argocd_install
  to = module.argocd.kubectl_manifest.manifest
}

moved {
  from = kubernetes_namespace.argocd
  to = module.argocd.kubernetes_namespace.namespace[0]
}
