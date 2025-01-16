# outputs.tf

output "vpc_id" {
  description = "ID de la VPC"
  value       = aws_vpc.main.id
}

output "private_subnet_ids" {
  description = "IDs de las subnets privadas"
  value       = aws_subnet.private[*].id
}

output "public_subnet_ids" {
  description = "IDs de las subnets públicas"
  value       = aws_subnet.public[*].id
}

output "eks_cluster_endpoint" {
  description = "Endpoint del cluster EKS"
  value       = aws_eks_cluster.main.endpoint
}

output "eks_cluster_name" {
  description = "Nombre del cluster EKS"
  value       = aws_eks_cluster.main.name
}

output "eks_cluster_security_group_id" {
  description = "Security Group ID del cluster EKS"
  value       = aws_security_group.eks_cluster.id
}

output "rds_endpoint" {
  description = "Endpoint de la base de datos RDS"
  value       = var.project_type == "database" ? aws_db_instance.main[0].endpoint : null
}

output "documentdb_endpoint" {
  description = "Endpoint del cluster DocumentDB"
  value       = var.project_type == "storage" ? aws_docdb_cluster.main[0].endpoint : null
}

output "s3_bucket_name" {
  description = "Nombre del bucket S3"
  value       = var.project_type == "storage" ? aws_s3_bucket.main[0].id : null
}