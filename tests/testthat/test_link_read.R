context("Testing link_read()")

uid <- as.character(random_hash())
data_product1 <- paste("test/csv", uid, sep = "_")
coderun_description <- "Register a file in the pipeline"
dataproduct_description <- "A csv file"
namespace1 <- "username"

endpoint <- Sys.getenv("FDP_endpoint")

# User written config file
config_file <- paste0("config_files/link_read/config_", uid , ".yaml")

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
handle <- initialise(config, script)

# Write data
path <- link_write(handle, data_product1)
df <- data.frame(a = uid, b = uid)
write.csv(df, path)

finalise(handle)


# Run tests ---------------------------------------------------------------

# User written config file
config_file <- paste0("config_files/link_read/config2_", uid , ".yaml")

write_config(path = config_file,
             description = coderun_description,
             input_namespace = namespace1,
             output_namespace = namespace1)
read_dataproduct(path = config_file,
                 data_product = data_product1)

# CLI functions
fair_pull(path = config_file)
fair_run(path = config_file, skip = TRUE)

# Initialise code run
config <- file.path(Sys.getenv("FDP_CONFIG_DIR"), "config.yaml")
script <- file.path(Sys.getenv("FDP_CONFIG_DIR"), "script.sh")
handle <- initialise(config, script)

# Read data
test_that("function behaves as it should", {
  path <- link_read(handle, data_product1)
  testthat::expect_true(is.character(path))
  tmp <- read.csv(path)
  testthat::expect_equal(tmp[,-1], df)
})
