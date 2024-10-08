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
  file_paths <- list.files(folder_path, full.names = TRUE)

  file_names <- list.files(folder_path, full.names = FALSE)

  file_extensions <- tools::file_ext(file_names)

  file_sizes <- file.info(file_paths)$size / 1024 # convert to KB

  current_datetime <- Sys.time()

  df <- tibble::tibble(
    file_path = file_paths
    , file_name = file_names
    , file_extension = file_extensions
    , file_size = file_sizes
    , current_datetime
  )

  return(df)
}
