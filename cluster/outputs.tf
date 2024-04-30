output "host" {
  value = scaleway_k8s_cluster.k8s.kubeconfig[0].host
  sensitive = true
}

output "token" {
  value = scaleway_k8s_cluster.k8s.kubeconfig[0].token
  sensitive = true
}

output "cluster_ca_certificate" {
  value = scaleway_k8s_cluster.k8s.kubeconfig[0].cluster_ca_certificate
  sensitive = true
}

output "config_file" {
  value = scaleway_k8s_cluster.k8s.kubeconfig[0].config_file
  sensitive = true
}

