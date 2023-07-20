locals {
  database = {
    "aim"                = {
      sku_name        = "GP_S_Gen5_4"
      zone_redundant  = true
      license_type    = "BasePrice"
      min_capacity    = "10"
      max_size_gb     = "50"
    }
  }
}