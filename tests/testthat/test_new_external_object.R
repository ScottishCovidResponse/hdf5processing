context("Testing new_external_object()")

UID <- paste0("test_new_external_object_",
              openssl::sha1(x = as.character(Sys.time())))
path <- paste0(UID, ".h5")
path_url <- paste0("https://", path)
hash <- sha1(UID)

endpoint <- Sys.getenv("FDP_endpoint")
if (grepl("localhost", endpoint)) run_server()

storage_root_url <- post_data("storage_root",
                              list(root = path_url),
                              endpoint = endpoint)

storage_location_url <- post_data("storage_location",
                                list(path = path,
                                     hash = hash,
                                     storage_root = storage_root_url),
                                endpoint = endpoint)

object_url <- post_data("object", list(desription = "text",
                                       storage_location_url = storage_location_url),
                        endpoint = endpoint)

namespace_url <- post_data("namespace",
                           list(name = "testuser",
                                full_name = "testuser"),
                           endpoint = endpoint)

data_product_url <- post_data("data_product",
                              list(name = UID,
                                   version = "0.1.0",
                                   object = object_url,
                                   namespace = namespace_url),
                              endpoint = endpoint)

test_that("New external object creates an external object with all fields", {
  expect_true(grepl("external_object",
                    new_external_object(doi_or_unique_name = UID,
                                        primary_not_supplement = TRUE,
                                        release_date = Sys.time(),
                                        title = UID,
                                        description = UID,
                                        data_product_url = data_product_url,
                                        original_store_url = storage_location_url,
                                        endpoint = endpoint)))
})
