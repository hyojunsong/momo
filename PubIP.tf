resource "azurerm_public_ip" "Public_ip" {
    name                = var.Public_ip_name[count.index]
    resource_group_name = azurerm_resource_group.RG.name
    location            = azurerm_resource_group.RG.location
    count               = var.coun
    allocation_method   = "Dynamic"
    tags                = var.tag
}