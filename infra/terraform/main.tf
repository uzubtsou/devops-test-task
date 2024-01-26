provider "minikube" {
  kubernetes_version = "v1.28.3"
}

resource "minikube_cluster" "test_task" {
  cluster_name = "test-task"

  driver            = "podman"
  container_runtime = "cri-o"

  addons = [
    "default-storageclass",
    "storage-provisioner"
  ]
}

