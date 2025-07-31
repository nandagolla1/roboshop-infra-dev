variable "project" {
  default = "roboshop"
}

variable "environment" {
  default = "dev"
}

variable "frontend_sg_name" {
    type = string
  default = "frontend"
}

variable "frontend_sg_description" {
  type = string
  default = "created sg for frontend instance."
}

variable "bastion_sg_name" {
    type = string
  default = "bastion"
}

variable "bastion_sg_description" {
  type = string
  default = "created sg for bastion instance."
}

variable "backend_alb_sg_name" {
    type = string
  default = "backend_alb"
}

variable "backend_alb_sg_description" {
  type = string
  default = "created sg for backend alb instance."
}

variable "vpn_sg_name" {
    type = string
  default = "vpn"
}

variable "vpn_sg_description" {
  type = string
  default = "created sg vpn."
}

variable "mongodb_sg_name" {
    type = string
  default = "mongodb"
}

variable "mongodb_sg_description" {
  type = string
  default = "created mongodb sg."
}

variable "mongodb_ports" {
  type = list(string)
  default = [ "22", "27017" ]
}

variable "redis_sg_name" {
    type = string
  default = "redis"
}

variable "redis_sg_description" {
  type = string
  default = "created redis sg."
}

variable "redis_ports" {
  type = list(string)
  default = [ "22", "6379" ]
}

variable "mysql_sg_name" {
    type = string
  default = "mysql"
}

variable "mysql_sg_description" {
  type = string
  default = "created mysql sg."
}

variable "mysql_ports" {
  type = list(string)
  default = [ "22", "3306" ]
}

variable "rabbitmq_sg_name" {
    type = string
  default = "rabbitmq"
}

variable "rabbitmq_sg_description" {
  type = string
  default = "created rabbitmq sg."
}

variable "rabbitmq_ports" {
  type = list(string)
  default = [ "22", "5672" ]
}

variable "catalogue_sg_name" {
    type = string
  default = "catalogue"
}

variable "catalogue_sg_description" {
  type = string
  default = "created catalogue sg."
}

variable "user_sg_name" {
    type = string
  default = "user"
}

variable "user_sg_description" {
  type = string
  default = "created user sg."
}

variable "cart_sg_name" {
    type = string
  default = "cart"
}

variable "cart_sg_description" {
  type = string
  default = "created cart sg."
}

variable "shipping_sg_name" {
    type = string
  default = "shipping"
}

variable "shipping_sg_description" {
  type = string
  default = "created shipping sg."
}

variable "payment_sg_name" {
    type = string
  default = "payment"
}

variable "payment_sg_description" {
  type = string
  default = "created payment sg."
}

variable "frontend_alb_sg_name" {
    type = string
  default = "frontend_alb"
}

variable "frontend_alb_sg_description" {
  type = string
  default = "created sg for frontend alb instance."
}