terraform {
  required_providers {
    http = {
      source = "hashicorp/http"
      version = "~> 3.4.2"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.29.0"
    }
    kubectl = {
      source = "alekc/kubectl"
      version = "~> 2.0.4"
    }
  }
}

