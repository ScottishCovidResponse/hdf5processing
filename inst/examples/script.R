library(rFDP)

run_server()

config_file <- "config1.yaml"
fdp_pull(config_file)
fdp_run(config_file, skip = TRUE)

config <- file.path(Sys.getenv("FDP_CONFIG_DIR"), "config.yaml")
script <- file.path(Sys.getenv("FDP_CONFIG_DIR"), "script.sh")

handle <- initialise(config, script)

data <- data.frame(a = 1:2, b = 3:4)
rownames(data) <- 1:2

write_array(array = as.matrix(data),
            handle = handle,
            data_product = "test/array",
            component = "duck-count",
            description = "a component of a test array",
            dimension_names = list(rowvalue = rownames(data),
                                   colvalue = colnames(data)))

finalise(handle)

file <- handle$outputs$path
rFDP:::findme(file)
