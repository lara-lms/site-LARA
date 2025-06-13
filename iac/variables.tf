variable "app_namme" {
  type = string
  default = "lara-site"
}

variable "image_tag" {
  type = string
  default = "v1" # TODO change to be latest, but need to improve image push
}

variable "app_container_port" {
  type = number
  default = 80
}
