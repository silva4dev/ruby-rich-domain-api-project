
resource "kubernetes_deployment" "nginx_terraform_a" {
  metadata {
    name      = "nginx-terraform-a"
    namespace = "default"
    labels = {
      app     = "nginx-terraform"
      version = "A"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "nginx-terraform"
        version = "A"
      }
    }

    template {
      metadata {
        labels = {
          app     = "nginx-terraform"
          version = "A"
        }
      }

      spec {
        container {
          name  = "nginx-terraform-a"
          image = "nginx"
          port {
            container_port = 80
          }
        }
      }
    }
  }
}

resource "kubernetes_deployment" "nginx_terraform_b" {
  metadata {
    name      = "nginx-terraform-b"
    namespace = "default"
    labels = {
      app     = "nginx-terraform"
      version = "B"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "nginx-terraform"
        version = "B" 
      }
    }

    template {
      metadata {
        labels = {
          app     = "nginx-terraform"
          version = "B"
        }
      }

      spec {
        container {
          name  = "nginx-terraform-b"
          image = "nginx"
          port {
            container_port = 80
          }
        }
      }
    }
  }
}

