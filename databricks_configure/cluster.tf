resource "databricks_cluster" "cluster_with_table_access_control" {
  cluster_name            = "Shared High-Concurrency"
  spark_version           = data.databricks_spark_version.latest_lts.id
  node_type_id            = data.databricks_node_type.smallest.id
  autotermination_minutes = 20

  spark_conf = {
    "spark.databricks.repl.allowedLanguages" : "python,sql",
    "spark.databricks.cluster.profile" : "serverless"
  }

  custom_tags = {
    "ResourceClass" = "test"
  }
}