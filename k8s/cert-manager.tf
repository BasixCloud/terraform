module "cert_manager" {
  source     = "./modules/cert-manager"
  depends_on = [module.vault] # CSI Secrets Providers should be ready
  email      = var.email
}

