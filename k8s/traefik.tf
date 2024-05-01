module "traefik" {
  source = "./modules/traefik"
}

data "kubernetes_service" "traefik_loadbalancer" {
  depends_on = [module.traefik]
  metadata {
    namespace = module.traefik.namespace_name
    name      = "traefik"
  }
}

