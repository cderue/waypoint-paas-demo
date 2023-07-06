variable "registry_username" {
  type = string
  default = ""
  env = ["REGISTRY_USERNAME"]
}

variable "registry_password" {
  type = string
  sensitive = true
  default = ""
  env = ["REGISTRY_PASSWORD"]
}

project = "paas-demo"

app "my-2048-app" {

  build {
    use "docker" {}
    registry {
      use "docker" {
        image = "${var.registry_username}/2048-app"
        tag = "latest"
        local = false
        auth {
          username = var.registry_username
          password = var.registry_password
        }
      }
    }
  }

  deploy {
    use "kubernetes" {
      probe_path = "/"
    }
  }

  release {
    use "kubernetes" {
       // Sets up a load balancer to access released application
      load_balancer = true
      port          = 3000
    }
  }
}