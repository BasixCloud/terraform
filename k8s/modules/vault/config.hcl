ui = true

listener "tcp" {
  tls_disable = 1
  address = "[::]:8200"
  cluster_address = "[::]:8201"
  # Enable unauthenticated metrics access (necessary for Prometheus Operator)
  telemetry {
    unauthenticated_metrics_access = "true"
  }
}

storage "raft" {
  path = "/vault/data"
}

service_registration "kubernetes" {}

# Example configuration for using auto-unseal, using Google Cloud KMS. The
# GKMS keys must already exist, and the cluster must have a service account
# that is authorized to access GCP KMS.
#seal "gcpckms" {
#   project     = "vault-helm-dev-246514"
#   region      = "global"
#   key_ring    = "vault-helm-unseal-kr"
#   crypto_key  = "vault-helm-unseal-key"
#}

# Example configuration for enabling Prometheus metrics.
# If you are using Prometheus Operator you can enable a ServiceMonitor resource below.
# You may wish to enable unauthenticated metrics in the listener block above.
#telemetry {
#  prometheus_retention_time = "30s"
#  disable_hostname = true
#}
