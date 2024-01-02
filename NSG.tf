resource "azurerm_network_security_group" "NSG" {
  count = var.coun
  name = var.NSG-name[count.index]
  location = var.RG-location
  resource_group_name = var.RG-name
  tags = var.tag
  security_rule {
    name                       = var.security_rule_name[count.index]
    priority                   = var.security_rule_priority[count.index]
    direction                  = var.security_rule_direction[count.index]
    access                     = var.security_rule_access[count.index]
    protocol                   = var.security_rule_protocol[count.index]
    source_port_range          = var.security_rule_source_port_range[count.index]
    destination_port_range     = var.security_rule_destination_port_range[count.index]
    source_address_prefix      = var.security_rule_source_address_prefix[count.index]
    destination_address_prefix = var.security_rule_destination_address_prefix[count.index]
  }
  depends_on = [azurerm_resource_group.RG]
}


############################################################################
#NIC-NSG
/*
resource "azurerm_network_interface_security_group_association" "join" {
  count = var.coun
  network_interface_id = azurerm_network_interface.NIC[count.index].id
  network_security_group_id = azurerm_network_security_group.NSG[count.index].id
  depends_on = [azurerm_network_interface.NIC]
}
*/

############################################################################
#SUB-NSG
resource "azurerm_subnet_network_security_group_association" "join" {
  count = var.coun
  subnet_id                 = azurerm_subnet.Subnet[count.index].id
  network_security_group_id = azurerm_network_security_group.NSG[count.index].id
  depends_on = [azurerm_subnet.Subnet]
}
