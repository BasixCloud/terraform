output "namespace" {
  value = var.namespace != null ? kubernetes_namespace.namespace[0].id : null
}

output "uid" {
  value = kubectl_manifest.manifest[*].uid
}

output "kind" {
  value = kubectl_manifest.manifest[*].kind
}
