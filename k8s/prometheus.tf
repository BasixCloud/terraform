resource "kubernetes_namespace" "prometheus" {
  metadata {
    generate_name = "prometheus"
  }
}

resource "helm_release" "prometheus" {
  name       = "kube-prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  version    = "58.2.22"
  namespace  = kubernetes_namespace.prometheus.id

  set {
    name  = "alertmanager.enabled"
    value = "false"
  }
}
