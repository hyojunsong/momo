resource "azurerm_virtual_network" "VNET" {
  name                  = var.VNET-name[count.index]
  resource_group_name   = azurerm_resource_group.RG.name
  location              = azurerm_resource_group.RG.location
  count                 = var.coun
  address_space         = [var.VNET-ip[count.index]]
  tags                  = var.tag
  depends_on = [azurerm_resource_group.RG]
}

resource  "azurerm_subnet""Subnet" {
  name                  = var.sub-name[count.index]
  resource_group_name   = azurerm_resource_group.RG.name
  virtual_network_name  = azurerm_virtual_network.VNET[count.index].name
  count                 = var.coun
  address_prefixes      = [var.sub-ip[count.index]]
  depends_on = [azurerm_virtual_network.VNET]
}