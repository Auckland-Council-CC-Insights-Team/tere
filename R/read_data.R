#' Get The Names Of Files In A Folder
#'
#' @description Given a file path and a folder name, return the name of any
#'   files in that folder.
#'
#' @param file_path The path of the file.
#' @param folder_name The name of the folder housing the files.
#'
#' @return File names as a named fs_path character vector.
#'
#' @export
get_file_name <- function(file_path = tere::get_file_storage_path(), folder_name)
{
  file_name <- fs::dir_ls(paste0(file_path, folder_name)) |>
    stringr::word(start = -2, end = -1, sep = stringr::fixed("/")) |>
    stringr::word(1, sep = stringr::fixed("."))

  return(file_name)
}

# preparing fixes for read functions


#' Read Files
#'
#' @param file_names The name of the file(s) to be read.
#' @param file_path The path of the file(s) to be read
#' @param file_type The format of the file(s) to be read.
#' @param file_extension The file extension.
#' @param sheet The sheet number in the excel file(s) to be read. Defaults to
#'   the first sheet.
#' @param col_types The data type for the column. Default to NULL
#' @param skip The number of rows to skip before reading in the data.
#'
#' @return Data from the file(s)
#'
#' @export
read_file <- function(file_names
                      , file_path = paste0(tere::get_file_storage_path(), folder_name)
                      , file_type = c("excel", "csv", "txt")
                      , file_extension = c(".xlsx", ".xls", ".csv")
                      , sheet = 1
                      , col_types = NULL
                      , skip = 0)
{
  if(file_type == "excel")
  {
    data_with_names <- read_excel_file(file_names, file_path, file_extension,
                                       sheet, col_types, skip)
  }

  if(file_type == "csv")
  {
    data_with_names <- read_csv_file(file_names, file_path, skip)
  }

  if(file_type == "tsv")
  {
    data_with_names <- read_tsv_file(file_names, file_path, skip)
  }

  return(data_with_names)
}


#' Read An Excel File
#'
#' @param file_names The name of the Excel file, without the file extension.
#' @param file_path The path to the Excel file.
#' @param file_extension The file extension for this Excel file, either '.xlsx'
#'   or '.xls'.
#' @param sheet The sheet numbers to be read, by default the first sheet.
#' @param col_types The data type for the column. Default to NULL
#' @param skip The number of rows to skip before reading, by default zero rows
#'   are skipped.
#'
#' @return A tibble.
#'
#' @noRd
read_excel_file <- function(file_names
                            , file_path = paste0(tere::get_file_storage_path(), folder_name)
                            , file_extension = c(".xlsx", ".xls")
                            , sheet = 1
                            , col_types = NULL
                            , skip = 0) {
  data <- purrr::map(
    .x = file_names
    , .f = ~tere::get_excel_file(filename = .x
                                 , path = file_path
                                 , file_extension = file_extension
                                 , sheet = sheet
                                 , col_types = NULL
                                 , skip_rows = skip)
  )

  data_with_names <- bind_dataframes(data, file_names)

  return(data_with_names)
}


#' Read A CSV File
#'
#' @param file_names The name of the CSV file, without the file extension.
#' @param file_path The path to the CSV file.
#' @param skip The number of rows to skip before reading, by default zero rows
#'   are skipped.
#'
#' @return A tibble.
#'
#' @noRd
read_csv_file <- function(file_names
                          , file_path = paste0(tere::get_file_storage_path(), folder_name)
                          , skip = 0) {
  data <- purrr::map(
    .x = paste0(file_path, "/", file_names, ".csv")
    , .f = ~readr::read_delim(file = .x
                              , delim = ","
                              , col_types = "?"
                              , skip = skip)
    , .id = "file_name"
  )

  data_with_names <- bind_dataframes(data, file_names)

  return(data_with_names)
}


#' Read A TSV File
#'
#' @param file_names The name of the TSV file, without the file extension.
#' @param file_path The path to the TSV file.
#' @param skip The number of rows to skip before reading, by default zero rows
#'   are skipped.
#'
#' @return A tibble.
#'
#' @noRd
read_tsv_file <- function(file_names
                          , file_path = paste0(tere::get_file_storage_path(), folder_name)
                          , skip = 0) {
  data <- purrr::map(
    .x = paste0(file_path, "/", file_names, ".tsv")
    , .f = ~readr::read_tsv(file = .x
                            , col_types = "?"
                            , skip = skip)
    , .id = "file_name"
  )

  data_with_names <- bind_dataframes(data, file_names)

  return(data_with_names)
}


#' Name And Bind Dataframes
#'
#' @param data A list of dataframes.
#' @param file_names A character vector of file names from which each dataframe
#'   was derived, where the position of each file name in the character vector
#'   matches the position of the dataframe in the list.
#'
#' @return A tibble.
#'
#' @export
bind_dataframes <- function(data, file_names) {
  names(data) <- file_names

  data_with_names <- data |>
    purrr::list_rbind(names_to = "id") |>
    janitor::clean_names()

  return(data_with_names)
}
