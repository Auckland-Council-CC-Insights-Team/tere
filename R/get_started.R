#' Load packages
#'
#' Given a list of package names, append the purrr package to the list then check if they're all
#' installed (install them if not). Afterwards, load the packages via library().
#'
#' @param package_names a character vector of package names
#'
#' @return A stylised message in the console
#' @export
#'
#' @examples get_started(c("dplyr", "lubridate"))
get_started <- function(package_names) {
  package_names_with_purrr <- append(package_names, "purrr")
  get_packages(package_names_with_purrr)

  for(p in package_names) {
    library(p, character.only = TRUE)
  }

  cli::cli_alert_info("All packages installed and loaded. Happy coding!")
}

#' Install any packages that are not already installed
#'
#' Compare a list of package names (including utils) against installed packages, then install any as needed
#'
#' @param packages a character vector of package names
#'
#' @return A stylised message in the console
#' @export
#'
#' @examples get_packages(c("dplyr", "lubridate"))
get_packages <- function(packages) {
  append(packages, "utils")

  missing_packages <- setdiff(
    packages,
    rownames(installed.packages())
    )

  install.packages(missing_packages)

  if(length(missing_packages) > 0) {
    cli::cli_alert_info(
      paste0("The following packages have been installed: ", missing_packages)
    )
  } else {
    cli::cli_alert_info("You already have these packages installed. Ka rawe!")
  }
}

#' Retrieve the full path to the local SharePoint directory where your team's files are stored
#'
#' @return A string containing a Windows directory path, or else an error message
#' @export
#'
#' @examples get_file_storage_path()
get_file_storage_path <- function() {
  readRenviron(".Renviron")

  if(check_environment_variable(c("SHAREPOINT_FILE_STORAGE"))) {
    Sys.getenv("SHAREPOINT_FILE_STORAGE")
  } else {
    cli::cli_alert_warning("Environment variables are missing: SHAREPOINT_FILE_STORAGE")
    cli::cli_alert_warning("Please call create_environment_variable() and pass the path to your SharePoint directory.")
  }
}

#' Check if the user has their environment variables set up
#'
#' Given a list of environment variable names, return FALSE if
#' the user does not have any of  these set in their .Renviron file
#'
#' @param variable_names a character vector of environment variable names in the .Renviron file
#'
#' @return FALSE if any of the environment variables are not found, otherwise TRUE
check_environment_variable <- function(variable_names) {
  if(length(variable_names) == 0 | any(Sys.getenv(variable_names) == "")) {
    return(FALSE)
  } else {
    return(TRUE)
  }
}

#' Create a .Renviron file to help point to your SharePoint document library
#'
#' Given a path to your locally-sync'd SharePoint Document Library, create a .Renviron
#' file in the project root to store that information for future reference.
#'
#' @return A stylised message in the console
#' @export
#'
#' @examples create_environment_variable()
create_environment_variable <- function() {
  value <- readline("Paste the path to your locally-synchronised SharePoint directory: ")

  dir_path <- gsub("\\\\", "/", value)

  cat(
    paste0("SHAREPOINT_FILE_STORAGE='", dir_path, "'"),
    file = here::here(".Renviron")
  )

  return(
    cli::cli_alert_info("Successfully created the .Renviron file to store your directory path.")
    )
}
