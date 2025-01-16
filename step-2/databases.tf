# Subnet group para RDS
resource "aws_db_subnet_group" "main" {
  name       = "${var.project_name}-db-subnet-${var.environment}"
  subnet_ids = aws_subnet.private[*].id

  tags = {
    Name = "${var.project_name}-db-subnet-${var.environment}"
  }
}

# RDS Instance
resource "aws_db_instance" "main" {
  count = var.project_type == "database" ? 1 : 0

  identifier = "${var.project_name}-db-${var.environment}"

  engine         = var.db_engine
  engine_version = var.db_engine_version
  instance_class = var.db_instance_class

  allocated_storage = 20
  storage_type      = "gp2"

  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.rds.id]

  username = "dbadmin"
  password = "password123" # Recomendado: usar AWS Secrets Manager

  backup_retention_period = 7
  multi_az                = var.environment == "prod" ? true : false

  skip_final_snapshot = true

  tags = {
    Name = "${var.project_name}-db-${var.environment}"
  }
}

# DocumentDB (opcional)
resource "aws_docdb_cluster" "main" {
  count = var.project_type == "database" ? 0 : 1

  cluster_identifier = "${var.project_name}-docdb-${var.environment}"
  engine             = "docdb"

  master_username = "docdbadmin"
  master_password = "CHANGE_ME_BEFORE_APPLY" # Recomendado: usar AWS Secrets Manager

  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.rds.id]

  skip_final_snapshot = true

  tags = {
    Name = "${var.project_name}-docdb-${var.environment}"
  }
}

resource "aws_docdb_cluster_instance" "main" {
  count = var.project_type == "database" ? 0 : 1

  identifier         = "${var.project_name}-docdb-instance-${var.environment}"
  cluster_identifier = aws_docdb_cluster.main[0].id
  instance_class     = "db.t3.medium"

  tags = {
    Name = "${var.project_name}-docdb-instance-${var.environment}"
  }
}

# S3 Bucket (opcional)
resource "aws_s3_bucket" "main" {
  count = var.project_type == "storage" ? 1 : 0

  bucket = "${var.project_name}-storage-${var.environment}"

  tags = {
    Name = "${var.project_name}-storage-${var.environment}"
  }
}

resource "aws_s3_bucket_versioning" "main" {
  count = var.project_type == "storage" ? 1 : 0

  bucket = aws_s3_bucket.main[0].id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "main" {
  count = var.project_type == "storage" ? 1 : 0

  bucket = aws_s3_bucket.main[0].id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}