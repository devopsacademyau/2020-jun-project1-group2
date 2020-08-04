resource "aws_rds_cluster" "aurora_cluster" {
  cluster_identifier     = "aurora-cluster"
  engine                 = "aurora"
  engine_mode            = "serverless"
  availability_zones     = ["ap-southeast-2a", "ap-southeast-2b"]
  database_name          = "wordpressdb"
  master_username        = "admin123"
  master_password        = "admin123"
  db_subnet_group_name   = aws_db_subnet_group.aurora_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  skip_final_snapshot    = true
  deletion_protection    = false

  tags = {
    Name = "aurora-cluster"
  }
}

resource "aws_db_subnet_group" "aurora_subnet_group" {

  name        = "aurora_db_subnet_group"
  description = "Private subnets for Aurora instances"
  subnet_ids  = [module.vpc.pvt_sub_id_az_a, module.vpc.pvt_sub_id_az_b]

  tags = {
    Name = "aurora-subnet-group"
  }
}