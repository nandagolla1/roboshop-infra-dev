variable "project" {
  default = "roboshop"
}

variable "environment" {
  default = "dev"
}

variable "backend_alb_sg_name" {
    type = string
  default = "backend_alb"
}

variable "backend_alb_sg_description" {
  type = string
  default = "created sg for backend alb instance."
}

variable "zone_id" {
  default = "Z0241085GWXCWOXHL9YW"
}

variable "domain_name" {
  default = "nanda.cyou"
}