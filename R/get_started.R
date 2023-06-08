#' Efficiently read an Excel file
#'
#' Pass the name of an Excel file and instantly read it. Optionally specify a sheet name and other parameters.
#'
#' @param filename The name of the file, excluding the file extension (e.g. .xlsx)
#' @param sheetname The name or position of the sheet you'd like to read. Defaults to position 1.
#' @param skip_rows The number of rows to skip before any data is read from the sheet. Default to zero rows skipped.
#' @param path The full directory path to the file. Default to the file path you stored in .Renviron as MY_SHAREPOINT_FILES.
#'
#' @return A tibble
#' @export
#'
get_excel_file <- function(filename, sheetname = 1, skip_rows = 0, path = get_file_storage_path("MY_SHAREPOINT_FILES"), file_extension = c(".xlsx", ".xls")) {
  readxl::read_excel(
    path = paste0(path, "/", filename, file_extension),
    sheet = sheetname,
    skip = skip_rows,
    .name_repair = janitor::make_clean_names
  )
}

# test

#' Load packages
#'
#' Given a list of package names, append the purrr package to the list then check if they're all
#' installed (install them if not). Afterwards, load the packages via library().
#'
#' @param package_names a character vector of package names.
#'
#' @return A stylised message in the console.
#' @export
#'
#' @examples get_started(c("dplyr", "lubridate"))
get_started <- function(package_names) {
  package_names_with_purrr <- append(package_names, "purrr")
  get_packages(package_names_with_purrr)

  for(p in package_names) {
    library(p, character.only = TRUE)
  }

  print("All packages installed and loaded. Happy coding!")
}

#' Install any packages that are not already installed
#'
#' Compare a list of package names (including utils) against installed packages, then install any as needed.
#'
#' @param packages a character vector of package names.
#'
#' @return A stylised message in the console.
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
    print(
      paste0("The following packages have been installed: ", missing_packages)
    )
  } else {
    print("You already have these packages installed. Ka rawe!")
  }
}

#' Retrieve the full path to the local SharePoint directory where your team's files are stored
#'
#' @param dir_ref The name you assigned for your SharePoint Document Library when you called create_environment_variable(), defaults to "MY_SHAREPOINT_FILES".
#' @param renviron_path The path to the .Renviron file, defaults to your project's home directory.
#'
#' @return A string containing a Windows directory path, or else an error message.
#' @export
#'
#' @examples \dontrun{get_file_storage_path("MY_SHAREPOINT_FILES")}
get_file_storage_path <- function(dir_ref = "MY_SHAREPOINT_FILES", renviron_path = here::here(".Renviron")) {
  if(check_renviron(renviron_path)) {
    get_renviron(dir_ref)
  }
}

#' Check that a .Renviron exists
#'
#' @param renviron_path Path to the .Renviron file.
#'
#' @return Scalar logical indicating if the file was read successfully. Returned invisibly.
#'
#' @noRd
check_renviron <- function(renviron_path) {
  if (file.exists(renviron_path)) {
    readRenviron(renviron_path)
    return(TRUE)
  } else {
    print("You do not have a .Renviron file, or you passed the incorrect directory path.")
    print("Please call create_environment_variable('MY_SHAREPOINT_FILES') and pass the path to your SharePoint directory when prompted.")
      return(FALSE)
  }
}

#' Obtain the values of environment variables
#'
#' @param var_name Character vector of environment variable name(s).
#'
#' @return A vector of the same length as var_name.
#'
#' @noRd
get_renviron <- function(var_name) {
  if(check_environment_variable(c(var_name))) {
    Sys.getenv(var_name)
  } else {
    print(paste0("You have a .Renviron file but the following environment variables are missing: ", var_name))
    print("Please call create_environment_variable('MY_SHAREPOINT_FILES') and pass, for example, the path to your SharePoint directory when prompted.")
  }
}

#' Check if the user has their environment variables set up
#'
#' Given a list of environment variable names, return FALSE if
#' the user does not have any of  these set in their .Renviron file.
#'
#' @param variable_names a character vector of environment variable names in the .Renviron file.
#'
#' @return FALSE if any of the environment variables are not found, otherwise TRUE.
#'
#' @noRd
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
#' @param dir_ref A name for your SharePoint Document Library, using only capital letters and no spaces. Defaults to "MY_SHAREPOINT_FILES".
#'
#' @return A stylised message in the console.
#' @export
#'
#' @examples \dontrun{create_environment_variable("MY_SHAREPOINT_FILES")}
create_environment_variable <- function(dir_ref = "MY_SHAREPOINT_FILES") {
  value <- readline("Paste the path to your locally-synchronised SharePoint directory: ")

  dir_path <- gsub("\\\\", "/", value)

  cat(
    paste0(dir_ref, "='", dir_path, "'"),
    file = here::here(".Renviron")
  )

  return(
    print("Successfully created the .Renviron file to store your directory path.")
    )
}


#' Make a Data Frame Tidy
#'
#' @description Convert a data frame into a tibble, and clean the column names.
#'
#' @param data_frame The data frame that needs to be tidied.
#'
#' @return A tibble with the same number of columns and rows as the original
#'   data frame.
#'
#' @noRd
get_tidy_table <- function(data_frame) {
  tidy_table <- data_frame |>
    dplyr::as_tibble() |>
    janitor::clean_names()

  return(tidy_table)
}
