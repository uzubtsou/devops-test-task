provider "minikube" {
  kubernetes_version = "v1.28.3"
}

resource "minikube_cluster" "test_task" {
  cluster_name = "test-task"

  driver            = "docker"
  container_runtime = "containerd"

  addons = [
    "default-storageclass",
    "storage-provisioner"
  ]
}

