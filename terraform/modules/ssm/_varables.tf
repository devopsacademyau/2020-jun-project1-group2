variable "wordpress_db_host" {
  type = string
  description = "RDS database endpoint URL for connecting to the Wordpress database."
}

variable "wordpress_db_name" {
  type = string
  description = "Name of the RDS database used to hold the Wordpress data"
  default = "wordpress"
}

variable "wordpress_db_user" {
  type = string
  description = "Database username for establishing a connection to the Wordpress database"
  default = "wordpress"
}
