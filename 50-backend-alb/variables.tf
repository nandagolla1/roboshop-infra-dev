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