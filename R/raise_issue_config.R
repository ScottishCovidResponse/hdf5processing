#' raise_issue_config
#'
#' @param handle handle
#' @param issue issue
#' @param severity severity
#'
#' @export
#'
raise_issue_config <- function(handle,
                               issue,
                               severity) {

  handle$raise_issue(index = NA,
                     type = "config",
                     use_data_product = NA,
                     use_component = NA,
                     use_version = NA,
                     use_namespace = NA,
                     issue = issue,
                     severity = severity)

  usethis::ui_done("Recording issues in handle")
}

#' raise_issue_script
#'
#' @param handle handle
#' @param issue issue
#' @param severity severity
#'
#' @export
#'
raise_issue_script <- function(handle,
                               issue,
                               severity) {

  handle$raise_issue(index = NA,
                     type = "script",
                     use_data_product = NA,
                     use_component = NA,
                     use_version = NA,
                     use_namespace = NA,
                     issue = issue,
                     severity = severity)

  usethis::ui_done("Recording issues in handle")
}

#' raise_issue_repo
#'
#' @param handle handle
#' @param issue issue
#' @param severity severity
#'
#' @export
#'
raise_issue_repo<- function(handle,
                            issue,
                            severity) {

  handle$raise_issue(index = NA,
                     type = "repo",
                     use_data_product = NA,
                     use_component = NA,
                     use_version = NA,
                     use_namespace = NA,
                     issue = issue,
                     severity = severity)

  usethis::ui_done("Recording issues in handle")
}
