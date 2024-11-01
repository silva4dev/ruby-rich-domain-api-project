resource "kubernetes_service" "nginx_terraform_service" {
  metadata {
    name      = "${var.prefix}-terraform-service"
    namespace = "default"
  }

  spec {
    type = "LoadBalancer"

    selector = {
      app = "${var.prefix}-terraform"
    }

    port {
      port        = 5000
      target_port = 5000
      node_port   = 30001
    }
  }
}
