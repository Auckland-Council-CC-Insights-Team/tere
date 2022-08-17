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

  install.packages(missing_packages, repos = "http://cran.us.r-project.org")

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
#' @param dir_ref The name you assigned for your SharePoint Document Library when you called create_environment_variable()
#'
#' @return A string containing a Windows directory path, or else an error message
#' @export
#'
#' @examples \dontrun{get_file_storage_path()}
get_file_storage_path <- function(dir_ref) {
  if (file.exists(".Renviron")) {
    readRenviron(".Renviron")

    if(check_environment_variable(c(dir_ref))) {
      Sys.getenv(dir_ref)
    } else {
      cli::cli_alert_warning(paste0("You have a .Renviron file but the following environment variables are missing: ", dir_ref))
      cli::cli_alert_warning("Please call create_environment_variable('MY_SHAREPOINT_FILES') and pass the path to your SharePoint directory when prompted.")
    }
  } else {
    cli::cli_alert_warning("You do not have a .Renviron file.")
    cli::cli_alert_warning("Please call create_environment_variable('MY_SHAREPOINT_FILES') and pass the path to your SharePoint directory when prompted.")
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

#' Create a .Renviron file that points to your locally-synchronised SharePoint Document Library
#'
#' Given a path to your locally-sync'd SharePoint Document Library, create a .Renviron
#' file in the project root to store that information for future reference.
#'
#' @param dir_ref A name for your SharePoint Document Library, using only capital letters and no spaces
#'
#' @return A stylised message in the console
#' @export
#'
#' @examples \dontrun {create_environment_variable("MY_SHAREPOINT_FILES")}
create_environment_variable <- function(dir_ref) {
  value <- readline("Paste the path to your locally-synchronised SharePoint directory: ")

  dir_path <- gsub("\\\\", "/", value)

  cat(
    paste0(dir_ref, "='", dir_path, "'"),
    file = here::here(".Renviron")
  )

  return(
    cli::cli_alert_info("Successfully created the .Renviron file to store your directory path.")
    )
}
