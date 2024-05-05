terraform {
  cloud {
    organization = "Basix"
    workspaces {
      name = "vault"
    }
  }
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "0.54.0"
    }
    vault = {
      source = "hashicorp/vault"
      version = "4.2.0"
    }
  }
  required_version = "~> 1.6.6"
}

data "tfe_outputs" "cluster" {
  organization = "Basix"
  workspace    = "cluster"
}

data "tfe_outputs" "kubernetes" {
  organization = "Basix"
  workspace    = "kubernetes"
}

provider "vault" {
  address = var.host
  token = var.token
}

