module "namespoke" {
  source  = "Azure/naming/azurerm"
  version = "0.2.0"
  suffix  = [var.prefix, "spk", var.suffix, var.loc]
}

module "namehub" {
  source  = "Azure/naming/azurerm"
  version = "0.2.0"
  suffix  = [var.prefix, "hub", var.suffix, var.loc]
}

module "namelaw" {
  source  = "Azure/naming/azurerm"
  version = "0.2.0"
  suffix  = [var.prefix, "logs", var.suffix, var.loc]
}