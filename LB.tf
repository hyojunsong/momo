############################################################################

# resource "azurerm_lb_backend_address_pool" "CGD-Backend" {
#   loadbalancer_id = azurerm_lb.CGD-LB[count.index].id
#   count = var.coun
#   name            = "Backend_pool"
# }

# resource "azurerm_lb_backend_address_pool_address" "add-a" {
#   name                    = var.backend-add-name[count.index]
#   backend_address_pool_id = azurerm_lb_backend_address_pool.CGD-Backend[count.index].id
#   virtual_network_id      = azurerm_virtual_network.VN[count.index].id
#   count = var.coun
#   ip_address = var.backend-ip-add[count.index]
# }

# resource "azurerm_lb_probe" "CGD-probe" {
#  loadbalancer_id     = azurerm_lb.CGD-LB[count.index].id
#  count = var.coun
#  name                = "CGD-probe"
#  port                = "80"
# }

# resource "azurerm_lb_rule" "CGD-rule" {
#   count = var.coun
#   loadbalancer_id                = azurerm_lb.CGD-LB[count.index].id
#   name                           = "LBRule"
#   protocol                       = "Tcp"
#   frontend_port                  = 80
#   backend_port                   = 80
#   probe_id                       = azurerm_lb_probe.CGD-probe[count.index].id
#   backend_address_pool_ids = [ azurerm_lb_backend_address_pool.CGD-Backend[count.index].id ]
#   frontend_ip_configuration_name = "CGD_frontend"
# }