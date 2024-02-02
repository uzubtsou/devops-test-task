variable "application_namespace" {
  description = "Namespace to deploy application"
  type        = string
  default     = "develop"
}

variable "backend_port" {
  description = "Port for backend service"
  type        = string
  default     = "8080"
}

variable "frontend_port" {
  description = "Port for frontend service"
  type        = string
  default     = "3000"
}

variable "postgresql_version" {
  description = "Version of PSQL to use"
  type        = string
  default     = "14.2.0"
}

variable "postgresql_user" {
  description = "User for PSQL to use"
  type        = string
  default     = "postgres"
}

variable "postgresql_password" {
  description = "Super secret password for PSQL to use"
  type        = string
  sensitive   = true
  default     = "postgres"
}

variable "postgresql_chart_version" {
  description = "Chart version for helm"
  type        = string
  default     = "13.4.3"
}

variable "postgresql_database_name" {
  description = "Postgresql database name"
  type        = string
  default     = "coffee_dev"
}

variable "api_key_token" {
  description = "Secret token for backend"
  type        = string
  sensitive   = true
  default     = "token"
}
