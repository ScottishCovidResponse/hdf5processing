#' Get GitHub package info
#'
#' Function to retrieve the current version of a GitHub repository and the
#' GitHub hash associated with it. The repository should contain a DESCRIPTION
#' file whether it is set up as a package or not. If the repository is set up
#' as a package, checks are made to ensure remote and local versions of the
#' package have the same version number.
#'
#' @param repo a \code{string} specifying the github username/repository
#' @param script_path a \code{string} specifying the submission script filename
#' and extension
#' @param package (optional) a \code{string} specifying the name of the package
#' containing the submission script
#'
#' @return Returns a list comprising:
#' * the github storage root name: "github"
#' * the github repository: e.g. "ScottishCovidResponse/SCRCdata"
#' * the github repository version number:
#' * the github repo hash
#' * the submission script file name
#'
#' @family get functions
#'
#' @export
#'
#' @examples
#' \donttest{
#' \dontrun{
#' get_package_info(repo = "ScottishCovidResponse/SCRCdata",
#' script_path = "scotgov_deaths.R",
#' package = "SCRCdata")
#' }}
#'
get_package_info <- function(repo, script_path, package) {
  # List files in repository
  filelist <- github_files(repo)

  # If repository contains a DESCRIPTION file, assume it's an R package
  if(any(grepl("DESCRIPTION", filelist, fixed = TRUE))) {

    # Check script exists in the repository
    if(!any(grepl(paste0(script_path, "$"), filelist)))
      stop(paste(script_path, "does not exist within", repo))

    # If a package does not exist, the GitHub repo should at least contain a
    # DESCRIPTION file
    if(missing(package)) {
      message(paste("The current githash has been downloaded from your repository.",
                    "If you have not yet pushed your processing script to this",
                    "repository, please PUSH IT NOW and run this function again."))

    } else {
      # If a package does exist, check that the version number in the GitHub repo
      # DESCRIPTION file matches the currently installed package version number
      if(!is_current_version(repo, package))
        stop(paste("Your package version is out of date please update it",
                   "and run this function again\n",
                   "Git Version: ", get_remote_package_version(repo),
                   "\n Local Version: ", get_loaded_package_version(package)))
    }
  }

  # Get the version number from the GitHub repo DESCRIPTION file
  repo_version <- get_remote_package_version(repo)

  list(repo_storageRoot = "github",
       script_gitRepo = repo,
       repo_version = repo_version,
       github_hash = get_github_hash(repo),
       submission_script = script_path)
}
