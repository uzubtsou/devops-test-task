provider "minikube" {
  kubernetes_version = "v1.27.2"
}

resource "minikube_cluster" "here" {
  cluster_name      = var.cluster_name
  driver            = var.minikube_driver
  container_runtime = var.minikube_runtime
  addons            = var.minikube_addons
}
