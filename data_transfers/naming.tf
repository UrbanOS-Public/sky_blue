module "namedata" {
  source  = "Azure/naming/azurerm"
  version = "0.2.0"
  suffix  = [var.prefix, "data", var.suffix, var.loc]
}
