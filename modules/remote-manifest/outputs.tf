output "namespace" {
  value = var.namespace != null ? kubernetes_namespace.namespace[0].id : null
}

output "manifest" {
  value = kubectl_manifest.manifest
}
