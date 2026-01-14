variable "environment" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}

variable "db_name" {
  type    = string
  default = "credpal"
}

variable "username" {
  type    = string
  default = "postgres"
}

variable "password" {
  type    = string
  default = "postgres"
}

variable "instance_class" {
  type    = string
  default = "db.t3.micro"
}

variable "security_group_id" {
  type = string
}
