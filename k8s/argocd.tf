resource "kubernetes_namespace" "argocd" {
  metadata {
    name = "argocd"
  }
}

variable "argocd_version" {
  description = "Argo CD version to deploy."
  type        = string
  default     = "v2.10.8"
}

data "http" "argocd_install_yaml" {
  url = format("https://raw.githubusercontent.com/argoproj/argo-cd/%s/manifests/install.yaml", var.argocd_version)

  # Optional request headers
  request_headers = {
    Accept = "application/x-yaml"
  }
}

data "kubectl_file_documents" "argocd_install_documents" {
  content = data.http.argocd_install_yaml.response_body
}

resource "kubectl_manifest" "argocd_install" {
  for_each           = data.kubectl_file_documents.argocd_install_documents.manifests
  yaml_body          = each.value
  override_namespace = kubernetes_namespace.argocd.id
}

module "argocd" {
  source = "../modules/remote-manifest"
  url =  format("https://raw.githubusercontent.com/argoproj/argo-cd/%s/manifests/install.yaml", var.argocd_version)
  namespace = "argocd"
}
