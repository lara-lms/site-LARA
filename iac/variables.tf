variable "app_name" {
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

variable "domain_name" {
  type = string
  default = "lara.local"
}

variable "docker_repository_name" {
  type = string
  default = "alaninformatica"
}
