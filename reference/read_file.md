# Read Files

Read Files

## Usage

``` r
read_file(
  file_names,
  file_path = paste0(tere::get_file_storage_path(), folder_name),
  file_type = c("excel", "csv", "txt"),
  file_extension = c(".xlsx", ".xls", ".csv"),
  sheet = 1,
  col_types = NULL,
  skip = 0
)
```

## Arguments

- file_names:

  The name of the file(s) to be read.

- file_path:

  The path of the file(s) to be read

- file_type:

  The format of the file(s) to be read.

- file_extension:

  The file extension.

- sheet:

  The sheet number in the excel file(s) to be read. Defaults to the
  first sheet.

- col_types:

  The data type for the column. Default to NULL

- skip:

  The number of rows to skip before reading in the data.

## Value

Data from the file(s)
