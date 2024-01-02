#NIC
resource "azurerm_network_interface" "NIC" {
    name                  = var.Static_NIC_name[count.index]
    resource_group_name   = azurerm_resource_group.RG.name
    location              = azurerm_resource_group.RG.location
    count = var.coun

    ip_configuration {
      name                                  = "ipconfig"
      subnet_id                             = azurerm_subnet.Subnet[count.index].id
      private_ip_address_allocation         = "Static"    #"Dynamic"
      private_ip_address                    = var.private_ip_add[count.index]
      public_ip_address_id                  = azurerm_public_ip.Public_ip[count.index].id
    }
    tags                                    = var.tag
    depends_on = [azurerm_virtual_network.VNET]
}

#Virtual_Machine
resource "azurerm_windows_virtual_machine" "VM" {
  count = var.coun
  name                = var.vm_name[count.index]
  resource_group_name = azurerm_resource_group.RG.name
  location            = azurerm_resource_group.RG.location
  size                = var.vm_size[count.index]
  computer_name       = var.computer_name[count.index]
  admin_username      = var.user_name[count.index]
  admin_password      = var.user_password[count.index]
  network_interface_ids = [azurerm_network_interface.NIC[count.index].id]

  os_disk {
    name                  = var.os_name[count.index]
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS" 
    disk_size_gb         = var.os_disk_size[count.index]
  }

 source_image_reference {
    publisher            = "MicrosoftWindowsDesktop"  #"MicrosoftWindowsServer"
    offer                = "Windows-10"
    sku                  = "win10-21h2-ent-g2"
    version              = "latest"
    } 

  tags = var.tag 
}


resource "azurerm_managed_disk" "managed-disk" {
  count                                 = var.coun
  name                                  = var.managed-disk-name[count.index]
  location                              = azurerm_resource_group.RG.location
  resource_group_name                   = azurerm_resource_group.RG.name
  storage_account_type                  = "StandardSSD_LRS"        #Standard_LRS, StandardSSD_ZRS, Premium_LRS, PremiumV2_LRS, Premium_ZRS, StandardSSD_LRS or UltraSSD_LRS.
  create_option                         = "Empty"
  disk_size_gb                          = var.managed_disk_size[count.index]
}

resource "azurerm_virtual_machine_data_disk_attachment" "sh-krc-avd-vm-disk0DATA-DISK-ADD" {
  count                                = var.coun
  managed_disk_id                       = azurerm_managed_disk.managed-disk[count.index].id
  virtual_machine_id                    = azurerm_windows_virtual_machine.VM[count.index].id
  lun                                   = "10"
  caching                               = "ReadWrite"
  depends_on = [azurerm_managed_disk.managed-disk]
}
