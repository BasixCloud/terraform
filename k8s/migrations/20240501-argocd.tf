moved {
  from = kubectl_manifest.argocd_install
  to = module.argocd.kubectl_manifest.manifest
}

moved {
  from = kubernetes_namespace.argocd
  to = module.argocd.kubernetes_namespace.namespace[0]
}
