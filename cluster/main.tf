terraform {
  cloud {
    organization = "Basix"
    workspaces {
      name = "cluster"
    }
  }
  required_providers {
    scaleway = {
      source  = "scaleway/scaleway"
      version = "2.40.0"
    }
  }
  required_version = "~> 1.6.6"
}

provider "scaleway" {
  zone   = "nl-ams-1"
  region = "nl-ams"
}

resource "scaleway_vpc_private_network" "k8s_net" {}

resource "scaleway_k8s_cluster" "k8s" {
  name                        = "k8s"
  version                     = "1.29"
  cni                         = "cilium"
  private_network_id          = scaleway_vpc_private_network.k8s_net.id
  delete_additional_resources = false
  auto_upgrade {
    enable                        = true
    maintenance_window_start_hour = 17
    maintenance_window_day        = "any"
  }
}

resource "scaleway_k8s_pool" "k8s_pool" {
  cluster_id = scaleway_k8s_cluster.k8s.id
  name       = "k8s-pool"
  node_type  = "PLAY2-MICRO"
  size       = 3
}

