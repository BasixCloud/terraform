output "namespace" {
  value = var.namespace ? kubernetes_namespace.namespace[0].id : null
}

output "id" {
  value = kubectl_manifest.manifest[*].id
}

output "kind" {
  value = kubectl_manifest.manifest[*].kind
}
