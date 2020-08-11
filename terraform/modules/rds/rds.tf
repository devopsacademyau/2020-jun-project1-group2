resource "aws_rds_cluster" "aurora_cluster" {
  cluster_identifier     = var.rds_cluster_name
  engine                 = var.rds_engine
  engine_mode            = var.rds_engine_mode
  database_name          = var.rds_database_name
  master_username        = var.rds_database_user
  master_password        = var.rds_database_password
  db_subnet_group_name   = aws_db_subnet_group.aurora_subnet_group.name
  vpc_security_group_ids = var.rds_security_group_ids
  skip_final_snapshot    = true
  deletion_protection    = false

  tags = {
    Name = "wp-aurora-cluster"
  }
}

resource "aws_db_subnet_group" "aurora_subnet_group" {

  name        = "aurora_db_subnet_group"
  description = "Private subnets for Aurora instances"
  subnet_ids  = var.rds_subnet_ids

  tags = {
    Name = "wp-aurora-subnet-group"
  }
}
