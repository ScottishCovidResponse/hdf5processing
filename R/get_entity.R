#' Get entity from url
#'
#' @param url a \code{string} specifying the url of an entry
#'
#' @export
#' @keywords internal
#'
#' @examples
#' \dontrun{
#' get_entity("http://localhost:8000/api/data_product/50/")
#' }
#'
get_entity <- function(url) {

  key <- get_token()
  h <- c(Authorization = paste("token", key))

  # Sometimes an error is returned from the local registry:
  #   "Error in curl::curl_fetch_memory(url, handle = handle) :
  #    Failed to connect to localhost port 8000: Connection refused"
  # Repeating the action works eventually...
  continue <- TRUE
  while (continue) {
    tryCatch({ # Try retrieving entry
      output <- httr::GET(url,
                          httr::add_headers(.headers = h)) %>%
        httr::content(as = "text", encoding = "UTF-8") %>%
        jsonlite::fromJSON(simplifyVector = FALSE)
      continue <- FALSE
    },
    error = function(e) {
    })
  }
  output
}
