variable "project" {
  default = "roboshop"
}

variable "environment" {
  default = "dev"
}

variable "mongodb_sg_name" {
    type = string
  default = "mongodb"
}

variable "mongodb_sg_description" {
  type = string
  default = "created mongodb sg."
}


variable "redis_sg_name" {
    type = string
  default = "redis"
}

variable "redis_sg_description" {
  type = string
  default = "created redis sg."
}

variable "mysql_sg_name" {
    type = string
  default = "mysql"
}

variable "mysql_sg_description" {
  type = string
  default = "created mysql sg."
}

variable "rabbitmq_sg_name" {
    type = string
  default = "rabbitmq"
}

variable "rabbitmq_sg_description" {
  type = string
  default = "created rabbitmq sg."
}