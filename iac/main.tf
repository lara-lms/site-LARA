provider "kubernetes" {
  config_path = "C:/Users/alanb/.kube/config/k3s.yaml"
}

resource "kubernetes_service" "lara_site_service" {
  metadata {
    name = var.app_name
  }

  spec {
    type = "ClusterIP"
    selector = {
      app = var.app_name
    }
    port {
      port = 8081
      target_port = var.app_container_port
    }
  }
}

resource "kubernetes_deployment" "lara_site_deployment" {
  metadata {
    name = var.app_name
    labels = {
      app = var.app_name
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = var.app_name
      }
    }

    template {
      metadata {
        labels = {
          app = var.app_name
        }
      }

      spec {
        container {
          name = var.app_name
          image = "${var.docker_repository_name}/${var.app_name}:${var.image_tag}"

          port {
            container_port = var.app_container_port
          }
        }
      }
    }
  }
}


resource "kubernetes_ingress_v1" "lara_site_ingress" {
  metadata {
    name      = "${var.app_name}-ingress"
    annotations = {
      "kubernetes.io/ingress.class" = "traefik"
    }
  }

  spec {
    ingress_class_name = "traefik"

    rule {
      host = var.domain_name

      http {
        path {
          path     = "/"
          path_type = "Prefix"
          backend {
            service {
              name = kubernetes_service.lara_site_service.metadata[0].name
              port {
                number = 8081
              }
            }
          }
        }
      }
    }
  }
}
