
resource "kubernetes_deployment" "nginx_terraform_a" {
  metadata {
    name      = "${var.prefix}-terraform-a"
    namespace = "default"
    labels = {
      app     = "${var.prefix}-terraform"
      version = "A"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "${var.prefix}-terraform"
        version = "A"
      }
    }

    template {
      metadata {
        labels = {
          app     = "${var.prefix}-terraform"
          version = "A"
        }
      }

      spec {
        container {
          name  = "${var.prefix}-terraform-a"
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
    name      = "${var.prefix}-terraform-b"
    namespace = "default"
    labels = {
      app     = "${var.prefix}-terraform"
      version = "B"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "${var.prefix}-terraform"
        version = "B" 
      }
    }

    template {
      metadata {
        labels = {
          app     = "${var.prefix}-terraform"
          version = "B"
        }
      }

      spec {
        container {
          name  = "${var.prefix}-terraform-b"
          image = "nginx"
          port {
            container_port = 80
          }
        }
      }
    }
  }
}

