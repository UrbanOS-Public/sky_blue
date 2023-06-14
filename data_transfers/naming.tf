module "namedata" {
  source  = "Azure/naming/azurerm"
  version = "0.3.0"
  suffix  = [var.prefix, "data", var.suffix, var.loc]
}

module "namelaw" {
  source  = "Azure/naming/azurerm"
  version = "0.3.0"
  suffix  = [var.prefix, "logs", var.suffix, var.loc]
}