terraform {
  required_version = "~> 1.5"

  required_providers {
    minikube = {
      source  = "scott-the-programmer/minikube"
      version = "0.3.7"
    }
  }
}
