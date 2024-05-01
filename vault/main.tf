terraform {
  cloud {
    organization = "Basix"
    workspaces {
      name = "vault"
    }
  }
  required_providers {
    vault = {
      source = "hashicorp/vault"
      version = "4.2.0"
    }
  }
}

provider "vault" {
  address = var.host
  token = var.token
}

