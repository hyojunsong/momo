resource "azurerm_resource_group" "RG" {
  name          = var.RG-name
  location      = var.RG-location
  tags          = var.tag
  //count         = var.coun
}