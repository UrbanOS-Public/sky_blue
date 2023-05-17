module "nameconvention" {
  source  = "../00_modules/naming"
  suffix  = ["mytest", var.suffix]
}