provider "aws" {
  region = var.region
}

module "vpc" {
  source          = "./vpc.tf"
  vpc_cidr        = var.vpc_cidr
  public_subnet_cidr = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
}

module "security_groups" {
  source    = "./security_groups.tf"
  vpc_id    = module.vpc.vpc_id
}

module "eks" {
  source = "./eks.tf"
  vpc_id = module.vpc.vpc_id
  eks_cluster_name = var.eks_cluster_name
  security_group_id = module.security_groups.eks_sg_id
}

module "rds" {
  source = "./rds.tf"
  db_instance_identifier = var.db_instance_identifier
  db_subnet_group_name = module.vpc.db_subnet_group_name
  security_group_id = module.security_groups.eks_sg_id
}

module "s3" {
  source = "./s3.tf"
  project_type = var.project_type
}
