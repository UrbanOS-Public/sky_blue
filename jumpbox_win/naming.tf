module "namespoke" {
  source  = "Azure/naming/azurerm"
  version = "0.3.0"
  suffix  = [var.prefix, "spk", var.suffix, var.loc]
}

module "namehub" {
  source  = "Azure/naming/azurerm"
  version = "0.3.0"
  suffix  = [var.prefix, "hub", var.suffix, var.loc]
}

module "namelaw" {
  source  = "Azure/naming/azurerm"
  version = "0.3.0"
  suffix  = [var.prefix, "logs", var.suffix, var.loc]
}

module "namejump" {
  source  = "Azure/naming/azurerm"
  version = "0.3.0"
  suffix  = [var.prefix, "jump", var.suffix, var.loc]
}