variable "rds_cluster_name" {
  type        = string
  description = "RDS cluster name"
}

variable "rds_engine" {
  type        = string
  description = "RDS engine, eg. aurora"
  default     = "aurora"
}

variable "rds_engine_mode" {
  type        = string
  description = "RDS engine mode, eg. serverless"
  default     = "serverless"
}

variable "rds_database_name" {
  type        = string
  description = "Database name, Eg. wordpress"
}

variable "rds_database_user" {
  type        = string
  description = "Database username to connect to DB"
}

variable "rds_database_password" {
  type        = string
  description = "Database password to connect to DB"
}

variable "rds_subnet_ids" {
  type        = list
  description = "Subnet ids to associate the RDS instance to"
}

variable "rds_security_group_ids" {
  type        = list
  description = "Security groups to associate with RDS"
}

