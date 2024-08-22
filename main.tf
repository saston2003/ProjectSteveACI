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
  default = "saston2003"
}


resource "azurerm_container_group" "aci-myapp" {
  name                = "aci-app"
  location            = "North Europe"
  resource_group_name = azurerm_resource_group.myacidemobook.name
  ip_address_type     = "public"
  dns_name_label      = "myapp-demo"
  os_type             = "linux"
  
  container {
    name   = "myappdemo"
    image  = "saston2003/mydemobook:v1"
    cpu    = "0.5"
    memory = "1.5"

    ports {
      port     = 80
      protocol = "TCP"
    }
  }
}
// image  = "docker.io/${var.dockerhub-username}/mydemobook:${var.imageversion}"