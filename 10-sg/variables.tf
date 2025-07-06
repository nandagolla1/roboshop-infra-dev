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

variable "sg_description" {
  type = string
  default = "created sg for frontend instance."
}