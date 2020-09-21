variable "resource_location" {
  type    = string
  default = "UK South"
}

variable "resource_prefix" {
  type    = string
  default = "CC-T-UKS"
}

variable "app_service_name" {
  default = ""
}

variable "mysql_root_password" {
  type    = string
  default = ""
}

variable "mysql_password" {
  type    = string
  default = ""
}