# terraform.tfvars.example

project_name = "tech-test-terraform"
environment  = "dev"
aws_region   = "us-east-1"

# Tipo de proyecto: "database" o "storage"
project_type = "database"

# Configuración de VPC
vpc_cidr           = "10.0.0.0/16"
availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
private_subnets    = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
public_subnets     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

# Configuración de EKS
eks_cluster_version     = "1.27"
eks_node_instance_types = ["t3.medium"]
eks_desired_nodes       = 2
eks_min_nodes           = 1
eks_max_nodes           = 4

# Configuración de Base de Datos
db_instance_class = "db.t3.medium"
db_engine         = "postgres" # o "mysql"
db_engine_version = "17.2"

# Tags por defecto
default_tags = {
  Environment = "dev"
  Terraform   = "true"
  Project     = "my-project"
}