terraform {
  cloud {
    organization = "Basix"
    workspaces {
      name = "cloudflare"
    }
  }

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.30.0"
    }
    tfe = {
      source  = "hashicorp/tfe"
      version = "0.54.0"
    }
  }
}

provider "cloudflare" {
  api_token = var.api_token
}

data "tfe_outputs" "kubernetes" {
  organization = "Basix"
  workspace    = "kubernetes"
}

resource "cloudflare_record" "basix_cloud_wildcard" {
  zone_id = var.zone_id
  name    = "*"
  type    = "A"
  proxied = true
  value   = data.tfe_outputs.kubernetes.nonsensitive_values.traefik_public_ip
}

