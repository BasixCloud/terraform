resource "kubernetes_namespace" "namespace" {
  count = var.namespace == null ? 0 : 1
  metadata {
    name = var.namespace
  }
}

data "http" "manifest_response" {
  url = var.url

  # Optional request headers
  request_headers = {
    Accept = "application/x-yaml"
  }
}

data "kubectl_file_documents" "documents" {
  content = data.http.manifest_response.response_body
}

resource "kubectl_manifest" "manifest" {
  for_each           = data.kubectl_file_documents.documents.manifests
  yaml_body          = each.value
  override_namespace = var.namespace ? kubernetes_namespace.namespace[0].id : null
}
