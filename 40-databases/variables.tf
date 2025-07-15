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