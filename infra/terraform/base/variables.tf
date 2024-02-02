variable "cluster_name" {
  description = "Name for minikube cluster"
  type        = string
  default     = "test-task"
}

variable "minikube_driver" {
  description = "minikube driver"
  type        = string
  default     = "docker"
}

variable "minikube_runtime" {
  description = "Containers runtime in minikube"
  type        = string
  default     = "containerd"
}

variable "minikube_addons" {
  description = "Addons to install in minikube"
  type        = list(string)
  default = [
    "default-storageclass",
    "storage-provisioner",
    "ingress",
    "ingress-dns"
  ]
}
