#' Check if the user has their environment variables set up
#'
#' Given a list of environment variable names, returns a warning in the console if
#' the user does not have these set in their .Renviron file
#'
#' @param variable_names names of the environment variables in the .Renviron file
#'
#' @return for any unmatched environment variables, a stylised message in the console
check_environment_variable <- function(variable_names) {
  get_packages("cli")

  if(any(Sys.getenv(variable_names) == "")) {
    stop(
      cli::cli_alert_warning(paste0("Environment variables are missing: ", variable_names)),
      cli::cli_alert_warning("Please read set-up vignette to configure your system.")
    )
  }
}

get_started <- function(package_names) {
  package_names_with_purrr <- append(package_names, "purrr")
  get_packages(package_names_with_purrr)

  for(p in package_names) {
    library(p, character.only = TRUE)
  }
}

get_packages <- function(packages) {
  install.packages(
    setdiff(
      packages,
      rownames(installed.packages())
    )
  )
}

get_file_storage_path <- function() {
  check_environment_variable(c("SHAREPOINT_FILE_STORAGE"))
  get_packages("stringr")
  get_packages("here")

  file_storage_partial <- Sys.getenv("SHAREPOINT_FILE_STORAGE")
  username <- stringr::str_split(here::here(), "/")[[1]][3]

  return(paste0("C:/Users/", username, file_storage_partial))
}
