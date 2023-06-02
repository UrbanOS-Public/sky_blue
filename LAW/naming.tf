module "namelaw" {
  source  = "Azure/naming/azurerm"
  version = "0.2.0"
  suffix  = [var.prefix, "logs", var.suffix, var.loc]
}
