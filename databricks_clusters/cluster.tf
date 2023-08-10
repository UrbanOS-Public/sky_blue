resource "databricks_cluster" "this" {
for_each = var.db_clusters
  cluster_name            = each.value.name
  node_type_id            = each.value.node_type_id #data.databricks_node_type.smallest.id
  spark_version           = each.value.spark_version #data.databricks_spark_version.latest_lts.id
  autotermination_minutes = each.value.cluster_autotermination_minutes
  num_workers             = each.value.cluster_num_workers
  data_security_mode      = each.value.data_security_mode
  single_user_name        = each.value.single_user_name
  runtime_engine          = each.value.runtime_engine
  enable_local_disk_encryption = true
  #policy_id               = "001E49A0A798AD86"
  spark_conf = {
    "spark.master": "local[*, 4]",
    "spark.databricks.cluster.profile": "singleNode",
    "spark.databricks.delta.preview.enabled": "true"
  }
  custom_tags = {
    "ResourceClass" = "SingleNode"
  }
  azure_attributes {
    availability       = each.value.availability
    first_on_demand    = each.value.first_on_demand
    spot_bid_max_price = each.value.spot_bid_max_price
  }
}
