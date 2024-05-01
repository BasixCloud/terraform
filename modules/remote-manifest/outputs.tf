output "namespace" {
  value = kubernetes_namespace.namespace.id
}

output "id" {
  value = kubectl_manifest.manifest.id
}
