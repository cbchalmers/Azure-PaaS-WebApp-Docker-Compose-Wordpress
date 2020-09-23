variable "resource_location" {
  description  = "Desired location to provision the resources. Eg UK South"
  type         = string
#  default = "UK South"
}

variable "resource_prefix" {
  description = "Desired prefix for the provisioned resources. Eg CC-D-UKS"
  type        = string
#  default = "CC-D-UKS"
}

variable "app_service_name" {
  description = "Desired external URL. This has to be globally unique to become https://your-app-service-name.azurewebsites.net"
  type    = string
#  default = ""
}

variable "mysql_root_password" {
  description = "Appropriate values which will be used to log into the database service"
  type        = string
#  default = ""
}

variable "mysql_password" {
  description = "Appropriate values which will be used to log into the database service"
  type        = string
#  default = ""
}