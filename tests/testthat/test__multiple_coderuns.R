context("Testing multiple coderuns")

# Write to registry -------------------------------------------------------

uid <- as.character(random_hash())
data_product1 <- file.path("output", "data", uid, "*")
coderun_description <- "Register a file in the pipeline"
dataproduct_description <- "A csv file"
namespace1 <- "username"

endpoint <- Sys.getenv("FDP_endpoint")
if (grepl("localhost", endpoint)) run_server()

# User written config file
config_file <- paste0("config_files/multicoderun/config_", uid , ".yaml")
write_config(path = config_file,
             description = coderun_description,
             input_namespace = namespace1,
             output_namespace = namespace1)
write_dataproduct(path = config_file,
                  data_product = data_product1,
                  description = dataproduct_description,
                  file_type = "csv")

# CLI functions
fair_pull(path = config_file)
fair_run(path = config_file, skip = TRUE)

# Initialise code run
config <- file.path(Sys.getenv("FDP_CONFIG_DIR"), "config.yaml")
script <- file.path(Sys.getenv("FDP_CONFIG_DIR"), "script.sh")

for (i in 1:3) {
  handle <- initialise(config, script)

  # Write data
  data_product_x <- file.path(dirname(data_product1), i)
  path <- link_write(handle, data_product_x)
  uid_x <- paste0(uid, "_", i)
  df_x <- data.frame(a = uid_x, b = uid_x)
  write.csv(df_x, path)

  finalise(handle)

  test_that("data products recorded in working config",{
    testthat::expect_equal(handle$outputs$data_product, data_product_x)
    testthat::expect_equal(handle$outputs$use_version, "0.0.1")
  })

  output_component_url <- get_entity(handle$code_run)$outputs[[1]]
  output_object_url <- get_entity(output_component_url)$object
  output_dp_url <- get_entity(output_object_url)$data_product
  output_dp_name <- get_entity(output_dp_url)$name

  test_that("data products recorded in registry",{
    testthat::expect_equal(output_dp_name, data_product_x)
  })
}
