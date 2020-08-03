variable "secure_strings" {
  description = "Array of secure string names to be created in SSM. Eg. /wordpress/WORDPRESS_DB_HOST. Note: All values must be set manually after the parameters are created."
  default     = []
}

