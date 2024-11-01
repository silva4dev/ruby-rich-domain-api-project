resource "kubernetes_service" "nginx_terraform_service" {
  metadata {
    name      = "nginx-terraform-service"
    namespace = "default"
  }

  spec {
    type = "LoadBalancer"

    selector = {
      app = "nginx-terraform"
    }

    port {
      port        = 5000
      target_port = 5000
      node_port   = 30001
    }
  }
}
