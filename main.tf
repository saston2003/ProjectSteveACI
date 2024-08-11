provider "azurerm" {
  features {}
}


resource "azurerm_resource_group" "myacidemobook" {
  name     = "mydemoBook-RG"
  location = "northeurope"
}

variable "imageversion" {
  description = "Tag of the image to deploy"
  default = "v1"
}

variable "dockerhub-username" {
  description = "DockerHub username"
}


resource "azurerm_container_group" "aci-myapp" {
  name                = "aci-app"
  location            = "North Europe"
  resource_group_name = azurerm_resource_group.mycidemobook.name
  ip_address_type     = "public"
  dns_name_label      = "myapp-demo"
  os_type             = "linux"
  
  container {
    name   = "myappdemo"
    image  = "docker.io/${var.dockerhub-username}/demobook:${var.imageversion}"
    cpu    = "0.5"
    memory = "1.5"

    ports {
      port     = 80
      protocol = "TCP"
    }
  }
}
