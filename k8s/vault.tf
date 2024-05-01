module "vault" {
  source = "./modules/vault"
  depends_on = [helm_release.secrets-store-csi-driver]
}
