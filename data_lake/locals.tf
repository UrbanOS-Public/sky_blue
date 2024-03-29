locals {
  adl_filesystem = {
    "raw" = {
      filesystem_name = "raw"
    }
    "standardized" = {
      filesystem_name = "standardized"
    }
    "enriched" = {
      filesystem_name = "enriched"
    }
  }

  adl_directory = {
    "fdos1" = {
      dir_name        = "fdos"
      resource        = "directory"
      filesystem_name = "raw"
    }
    "fdos2" = {
      dir_name        = "fdos"
      resource        = "directory"
      filesystem_name = "standardized"
    }
    "crash1" = {
      dir_name        = "crash"
      resource        = "directory"
      filesystem_name = "raw"
    }
    "crash2" = {
      dir_name        = "crash"
      resource        = "directory"
      filesystem_name = "standardized"
    }
    "intersections1" = {
      dir_name        = "intersections"
      resource        = "directory"
      filesystem_name = "raw"
    }
    "intersections2" = {
      dir_name        = "intersections"
      resource        = "directory"
      filesystem_name = "standardized"
    }  
    "weather1" = {
      dir_name        = "weather"
      resource        = "directory"
      filesystem_name = "raw"
    }
    "weather2" = {
      dir_name        = "weather"
      resource        = "directory"
      filesystem_name = "standardized"
    }
    "traffic_signals1" = {
      dir_name        = "traffic_signals"
      resource        = "directory"
      filesystem_name = "raw"
    }
    "traffic_signals2" = {
      dir_name        = "traffic_signals"
      resource        = "directory"
      filesystem_name = "standardized"
    }
    "boundaries1" = {
      dir_name        = "boundaries"
      resource        = "directory"
      filesystem_name = "raw"
    }
    "boundaries2" = {
      dir_name        = "boundaries"
      resource        = "directory"
      filesystem_name = "standardized"
    }  
    "other1" = {
      dir_name        = "other"
      resource        = "directory"
      filesystem_name = "raw"
    }
    "other2" = {
      dir_name        = "other"
      resource        = "directory"
      filesystem_name = "standardized"
    }
      "near_miss1" = {
      dir_name        = "near_miss"
      resource        = "directory"
      filesystem_name = "raw"
    }
    "near_miss2" = {
      dir_name        = "near_miss"
      resource        = "directory"
      filesystem_name = "standardized"
    }
    "active_projects1" = {
      dir_name        = "active_projects"
      resource        = "directory"
      filesystem_name = "raw"
    }
    "active_projects2" = {
      dir_name        = "active_projects"
      resource        = "directory"
      filesystem_name = "standardized"
    }
  }
}