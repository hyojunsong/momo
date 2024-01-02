####################################################################################################################################################################
#hostpool
resource "azurerm_virtual_desktop_host_pool" "host-pool" {
  location            = "East US"                //host pool korea central 미지원
  resource_group_name = var.RG-name

  name                     = var.host-pool-name
  validate_environment     = true
  start_vm_on_connect      = true
  custom_rdp_properties    = "audiocapturemode:i:1;audiomode:i:0;"
  type                     = var.host-pool-type        //"Pooled" or "Personal"                                  
  #maximum_sessions_allowed = 50
  personal_desktop_assignment_type = var.personal_desktop_assignment_type    // "Direct" or "Automatic" 
  load_balancer_type       =  var.hp-LB-type      //Pooled 방식 경우 "BreadthFirst"너비 "DepthFirst" 깊이        "Persistent"
  depends_on = [azurerm_resource_group.RG]
  /*scheduled_agent_updates {
    enabled = true
    schedule {
      day_of_week = "Saturday"
      hour_of_day = 2
    }
  }
  */

}

#####################################################################################################################################################################
#application_group remoteapp
/*
resource "azurerm_virtual_desktop_application_group" "remoteapp" {
  name                = "acctag"
  location            = "East US"
  resource_group_name = azurerm_resource_group.example.name

  type          = "RemoteApp"
  host_pool_id  = azurerm_virtual_desktop_host_pool.pooledbreadthfirst.id
  friendly_name = "TestAppGroup"
  description   = "Acceptance Test: An application group"
}
*/

#####################################################################################################################################################################
#application_group desktopapp
resource "azurerm_virtual_desktop_application_group" "desktopapp" {
  name                = var.desktopapp-name
  location            = "East US"
  resource_group_name = var.RG-name

  type          = "Desktop"
  host_pool_id  = azurerm_virtual_desktop_host_pool.host-pool.id
  depends_on = [azurerm_resource_group.RG]
  #friendly_name = "TestAppGroup"
  #description   = "Acceptance Test: An application group"
}


#####################################################################################################################################################################
#Workspace
resource "azurerm_virtual_desktop_workspace" "workspace" {
  name                = var.workspace-name
  location            = "East US"
  resource_group_name = var.RG-name
  depends_on = [azurerm_resource_group.RG]
  #friendly_name = "FriendlyName"
  #description   = "A description of my workspace"
}


#####################################################################################################################################################################
#workspace_application_group_association
resource "azurerm_virtual_desktop_workspace_application_group_association" "workspaceremoteapp" {
  workspace_id         = azurerm_virtual_desktop_workspace.workspace.id
  application_group_id = azurerm_virtual_desktop_application_group.desktopapp.id
}