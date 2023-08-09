resource "databricks_cluster" "this" {
for_each = var.db_clusters
  cluster_name            = each.value.name
  node_type_id            = data.databricks_node_type.smallest.id
  spark_version           = data.databricks_spark_version.latest_lts.id
  autotermination_minutes = each.value.cluster_autotermination_minutes
  num_workers             = each.value.cluster_num_workers
  data_security_mode      = each.value.data_security_mode
  single_user_name        = each.value.single_user_name
  #availability            = each.value.availability
 
}
