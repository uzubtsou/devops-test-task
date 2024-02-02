output "host" {
  description = "minikube host"
  value       = minikube_cluster.here.host
}

output "client_certificate" {
  description = "Client certificate"
  value       = minikube_cluster.here.client_certificate
  sensitive   = true
}

output "client_key" {
  description = "Client key"
  value       = minikube_cluster.here.client_key
  sensitive   = true
}

output "cluster_ca_certificate" {
  description = "Cluster CA certificate"
  value       = minikube_cluster.here.cluster_ca_certificate
  sensitive   = true
}
