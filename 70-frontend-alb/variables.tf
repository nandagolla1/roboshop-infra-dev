variable "project" {
  default = "roboshop"
}

variable "environment" {
  default = "dev"
}

variable "frontend_alb_sg_name" {
    type = string
  default = "frontend_alb"
}

variable "frontend_alb_sg_description" {
  type = string
  default = "created sg for frontend alb instance."
}

variable "zone_id" {
  default = "Z0241085GWXCWOXHL9YW"
}

variable "domain_name" {
  default = "nanda.cyou"
}