module "namepurview" {
  source  = "Azure/naming/azurerm"
  version = "0.3.0"
  suffix  = [var.prefix, "purview", var.suffix, var.loc]
}

module "namepurview2" {
  source  = "Azure/naming/azurerm"
  version = "0.3.0"
  suffix  = [var.prefix, "purvman", var.suffix, var.loc]
}

module "namedatalake" {
  source  = "Azure/naming/azurerm"
  version = "0.3.0"
  suffix  = [var.prefix, "adl", var.suffix, var.loc]
}

module "namelaw" {
  source  = "Azure/naming/azurerm"
  version = "0.3.0"
  suffix  = [var.prefix, "logs", var.suffix, var.loc]
}

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