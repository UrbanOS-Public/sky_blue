#Create Resource Group for databricks
resource "azurerm_resource_group" "databricks" {
  name     = module.nameadb.resource_group.name
  location = var.location
  tags     = var.tags
  depends_on = [ module.nameadb ]
}

resource "azurerm_databricks_workspace" "dp_workspace" {
  name                                  = module.nameadb.resource_group.databricks_workspace
  resource_group_name                   = module.nameadb.resource_group.name
  location                              = var.location
  sku                                   = "premium"
  tags                                  = var.tags
  public_network_access_enabled         = var.public_network_access_enabled
  network_security_group_rules_required = "NoAzureDatabricksRules"
  customer_managed_key_enabled          = true
  # custom_parameters {
  #   no_public_ip                                         = true
  #   virtual_network_id                                   = azurerm_virtual_network.dp_vnet.id
  #   private_subnet_name                                  = azurerm_subnet.dp_private.name
  #   public_subnet_name                                   = azurerm_subnet.dp_public.name
  #   public_subnet_network_security_group_association_id  = azurerm_subnet_network_security_group_association.dp_public.id
  #   private_subnet_network_security_group_association_id = azurerm_subnet_network_security_group_association.dp_private.id
  #   storage_account_name                                 = local.dbfsname
  # }
  depends_on = [
    azurerm_resource_group.databricks
    #azurerm_subnet_network_security_group_association.dp_public,
    #azurerm_subnet_network_security_group_association.dp_private
  ]
}