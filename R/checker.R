#' Get File Properties
#'
#' @description Get the properties of files within a folder
#'
#' @param folder_path The path of the folder
#'
#' @return A dataframe containing the files and their properties
#'
#' @export
get_file_properties <- function(folder_path)
{
  file_paths <- file_names <- file_extensions <-
    file_sizes <- current_datetime <- NULL

  file_paths <- list.files(folder_path, full.names = TRUE)

  file_names <- list.files(folder_path, full.names = FALSE)

  file_extensions <- tools::file_ext(file_names)

  file_sizes_kb <- file.info(file_paths)$size / 1024 # convert to KB

  current_datetime <- Sys.time()

  df <- tibble::tibble(
    file_path = file_paths
    , file_name = file_names
    , file_extension = file_extensions
    , file_size_kb = file_sizes_kb
    , current_datetime
  )

  return(df)
}

#' Check File Properties
#'
#' @description Check file properties and print a warning if the check fails.
#'
#'
#' @param df A dataframe
#'
#' @return A list containing two logical items
#'
#' @export
check_file_properties <- function(df)
{
  check_file_extension <- df |>
    dplyr::select(file_extension) |>
    dplyr::distinct(file_extension) |>
    length() == 1

  check_file_size <- df |>
    dplyr::select(file_size) |>
    dplyr::filter(
      !is.na(file_size) | file_size == 0
    ) |>
    nrow() == 0

  results <- list(
    check_file_extension = check_file_extension
    , check_file_size = check_file_size
  )

  if (!check_file_extension) {
    # we expect all files to have the same file extension
    message("Error: File extension check failed. There are one or more different file extensions in this folder")
  }

  if (check_file_size) {
    # we expect all files to be greater than 0
    # therefore show error message if check_file_size == TRUE
    message("Error: File size check failed. There are one or more files that are 0 KB")
  }

  return(results)
}
