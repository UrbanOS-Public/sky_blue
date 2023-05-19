module "namespoke" {
  source  = "Azure/naming/azurerm"
  version = "0.2.0"
  suffix  = [var.prefix, "spoke", var.suffix, var.loc]
}

module "namehub" {
  source  = "Azure/naming/azurerm"
  version = "0.2.0"
  suffix  = [var.prefix, "hub", var.suffix, var.loc]
}