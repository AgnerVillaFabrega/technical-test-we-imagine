# variables.tf

variable "project_name" {
  description = "Nombre del proyecto"
  type        = string
}

variable "environment" {
  description = "Ambiente de despliegue (dev, staging, prod)"
  type        = string
}

variable "aws_region" {
  description = "Región de AWS a utilizar"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR block para la VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "Lista de zonas de disponibilidad"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "private_subnets" {
  description = "Lista de CIDRs para subnets privadas"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "public_subnets" {
  description = "Lista de CIDRs para subnets públicas"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

variable "project_type" {
  description = "Tipo de proyecto (database o storage)"
  type        = string
  default     = "database"
}

variable "eks_cluster_version" {
  description = "Versión del cluster EKS"
  type        = string
  default     = "1.27"
}

variable "eks_node_instance_types" {
  description = "Tipos de instancia para los nodos de EKS"
  type        = list(string)
  default     = ["t3.medium"]
}

variable "eks_desired_nodes" {
  description = "Número deseado de nodos en el cluster EKS"
  type        = number
  default     = 2
}

variable "eks_min_nodes" {
  description = "Número mínimo de nodos en el cluster EKS"
  type        = number
  default     = 1
}

variable "eks_max_nodes" {
  description = "Número máximo de nodos en el cluster EKS"
  type        = number
  default     = 4
}

variable "db_instance_class" {
  description = "Tipo de instancia para RDS"
  type        = string
  default     = "db.t3.medium"
}

variable "db_engine" {
  description = "Motor de base de datos (postgres o mysql)"
  type        = string
  default     = "postgres"
}

variable "db_engine_version" {
  description = "Versión del motor de base de datos"
  type        = string
  default     = "14.7"
}

variable "default_tags" {
  description = "Tags por defecto para todos los recursos"
  type        = map(string)
  default = {
    Environment = "dev"
    Terraform   = "true"
  }
}