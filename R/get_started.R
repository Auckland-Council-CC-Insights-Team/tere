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

#' Retrieve the full path to the local SharePoint File Storage directory
#'
#' @return A string containing a Windows directory path, or else an error message
#' @export
#'
#' @examples get_file_storage_path()
get_file_storage_path <- function() {
  if(check_environment_variable(c("SHAREPOINT_FILE_STORAGE"))) {
    get_packages("stringr")
    get_packages("here")
    get_packages("cli")

    file_storage_partial <- Sys.getenv("SHAREPOINT_FILE_STORAGE")
    username <- stringr::str_split(here::here(), "/")[[1]][3]

    paste0("C:/Users/", username, file_storage_partial)
  } else {
    cli::cli_alert_warning(paste0("Environment variables are missing: SHAREPOINT_FILE_STORAGE"))
    cli::cli_alert_warning("Please read set-up vignette to configure your system.")
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
  if(!is.character) {
    stop(
      cli::cli_alert_warning("Your environment variable names are invalid. Did you pass a number instead of a character string?")
    )
  }

  if(length(variable_names) | any(Sys.getenv(variable_names) == "")) {
    return(FALSE)
  } else {
    return(TRUE)
  }
}
