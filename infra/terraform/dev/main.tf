data "terraform_remote_state" "minikube" {
  backend = "local"

  config = {
    path = "../base/terraform.tfstate"
  }
}

provider "helm" {
  kubernetes {
    host = data.terraform_remote_state.minikube.outputs.host

    client_certificate     = data.terraform_remote_state.minikube.outputs.client_certificate
    client_key             = data.terraform_remote_state.minikube.outputs.client_key
    cluster_ca_certificate = data.terraform_remote_state.minikube.outputs.cluster_ca_certificate
  }
}

resource "helm_release" "postgresql" {
  name       = "postgresql"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "postgresql"
  version    = var.postgresql_chart_version

  namespace        = var.application_namespace
  create_namespace = true

  set {
    name  = "image.tag"
    value = var.postgresql_version
  }
  set {
    name  = "global.postgresql.auth.username"
    value = var.postgresql_user
  }
  set_sensitive {
    name  = "global.postgresql.auth.password"
    value = var.postgresql_password
  }
  set {
    name  = "global.postgresql.auth.database"
    value = var.postgresql_database_name
  }
}

resource "helm_release" "backend" {
  name = "backend"
  # it's better to upload it somewhere actually
  chart = "../../kubernetes/backend/"

  namespace        = var.application_namespace
  create_namespace = true

  values = ["${file("backend.values.yaml")}"]

  set_sensitive {
    name  = "token"
    value = var.api_key_token
  }
  set {
    name  = "service.port"
    value = var.backend_port
  }
  set {
    name  = "database.username"
    value = var.postgresql_user
  }
  set {
    name  = "database.password"
    value = var.postgresql_password
  }
  set {
    name  = "database.host"
    value = helm_release.postgresql.name
  }
  set {
    name  = "database.name"
    value = var.postgresql_database_name
  }
  set {
    name  = "service.type"
    value = "LoadBalancer"
  }

  depends_on = [
    helm_release.postgresql
  ]
}

resource "helm_release" "frontend" {
  name = "frontend"
  # it's better to upload it somewhere actually
  chart = "../../kubernetes/frontend/"

  namespace        = var.application_namespace
  create_namespace = true

  values = ["${file("frontend.values.yaml")}"]

  set {
    name  = "backend.url"
    value = "http://localhost:${var.backend_port}"
  }
  set {
    name  = "service.type"
    value = "LoadBalancer"
  }
  set {
    name  = "service.port"
    value = var.frontend_port
  }

}
