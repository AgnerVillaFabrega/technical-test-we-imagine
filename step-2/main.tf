# Data source para obtener el ID de cuenta de AWS
data "aws_caller_identity" "current" {}

# Data source para obtener la región actual
data "aws_region" "current" {}

# Crear un KMS key para encriptación
resource "aws_kms_key" "main" {
  description             = "KMS key for ${var.project_name} ${var.environment}"
  deletion_window_in_days = 7
  enable_key_rotation     = true

  tags = {
    Name = "${var.project_name}-kms-${var.environment}"
  }
}

resource "aws_kms_alias" "main" {
  name          = "alias/${var.project_name}-${var.environment}"
  target_key_id = aws_kms_key.main.key_id
}

# Random string para nombres únicos (útil para recursos que requieren nombres únicos globales)
resource "random_string" "suffix" {
  length  = 8
  special = false
  upper   = false
}

# Datos de las zonas de disponibilidad si no se especifican
data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  # Nombre base para los recursos
  resource_prefix = "${var.project_name}-${var.environment}"

  # Zonas de disponibilidad a usar 
  azs = length(var.availability_zones) > 0 ? var.availability_zones : slice(data.aws_availability_zones.available.names, 0, 3)

  # Tags comunes para todos los recursos
  common_tags = merge(
    var.default_tags,
    {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "terraform"
    }
  )

  # Configuración condicional basada en el tipo de proyecto
  is_database_project = var.project_type == "database"
  is_storage_project  = var.project_type == "storage"

  # Configuración de endpoints de VPC
  vpc_endpoints = {
    s3 = {
      service = "s3"
      type    = "Gateway"
    }
    ecr_api = {
      service = "ecr.api"
      type    = "Interface"
    }
    ecr_dkr = {
      service = "ecr.dkr"
      type    = "Interface"
    }
  }
}

# VPC Endpoints para servicios AWS
resource "aws_vpc_endpoint" "s3" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.${data.aws_region.current.name}.s3"
  vpc_endpoint_type = "Gateway"

  route_table_ids = [
    aws_route_table.private.id,
    aws_route_table.public.id
  ]

  tags = merge(
    local.common_tags,
    {
      Name = "${local.resource_prefix}-s3-endpoint"
    }
  )
}

resource "aws_vpc_endpoint" "ecr_api" {
  vpc_id              = aws_vpc.main.id
  service_name        = "com.amazonaws.${data.aws_region.current.name}.ecr.api"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  subnet_ids = aws_subnet.private[*].id
  security_group_ids = [
    aws_security_group.eks_cluster.id
  ]

  tags = merge(
    local.common_tags,
    {
      Name = "${local.resource_prefix}-ecr-api-endpoint"
    }
  )
}

resource "aws_vpc_endpoint" "ecr_dkr" {
  vpc_id              = aws_vpc.main.id
  service_name        = "com.amazonaws.${data.aws_region.current.name}.ecr.dkr"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  subnet_ids = aws_subnet.private[*].id
  security_group_ids = [
    aws_security_group.eks_cluster.id
  ]

  tags = merge(
    local.common_tags,
    {
      Name = "${local.resource_prefix}-ecr-dkr-endpoint"
    }
  )
}

# SSM Parameter para almacenar información importante (opcional)
resource "aws_ssm_parameter" "cluster_name" {
  name        = "/${var.project_name}/${var.environment}/eks/cluster_name"
  description = "EKS Cluster Name"
  type        = "String"
  value       = aws_eks_cluster.main.name

  tags = local.common_tags
}

resource "aws_ssm_parameter" "db_endpoint" {
  count       = local.is_database_project ? 1 : 0
  name        = "/${var.project_name}/${var.environment}/database/endpoint"
  description = "Database Endpoint"
  type        = "String"
  value       = aws_db_instance.main[0].endpoint

  tags = local.common_tags
}