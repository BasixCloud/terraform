terraform {
  cloud {
    organization = "Basix"
    workspaces {
      name = "kubernetes"
    }
  }
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.29.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.13.1"
    }
    http = {
      source  = "hashicorp/http"
      version = "3.4.2"
    }
    kubectl = {
      source  = "alekc/kubectl"
      version = "2.0.4"
    }
    tfe = {
      source  = "hashicorp/tfe"
      version = "0.54.0"
    }
  }
  required_version = "~> 1.6.6"
}

data "tfe_outputs" "cluster" {
  organization = "Basix"
  workspace    = "cluster"
}

provider "kubernetes" {
  host                   = data.tfe_outputs.cluster.values.host
  token                  = data.tfe_outputs.cluster.values.token
  cluster_ca_certificate = base64decode(data.tfe_outputs.cluster.values.cluster_ca_certificate)
}

provider "kubectl" {
  host                   = data.tfe_outputs.cluster.values.host
  token                  = data.tfe_outputs.cluster.values.token
  cluster_ca_certificate = base64decode(data.tfe_outputs.cluster.values.cluster_ca_certificate)
  load_config_file       = false
}

provider "helm" {
  kubernetes {
    host                   = data.tfe_outputs.cluster.values.host
    token                  = data.tfe_outputs.cluster.values.token
    cluster_ca_certificate = base64decode(data.tfe_outputs.cluster.values.cluster_ca_certificate)
  }
}

