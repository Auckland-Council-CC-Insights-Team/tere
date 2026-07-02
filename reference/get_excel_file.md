# Efficiently read an Excel file

Pass the name of an Excel file and instantly read it. Optionally specify
a sheet name and other parameters.

## Usage

``` r
get_excel_file(
  filename,
  sheetname = 1,
  skip_rows = 0,
  path = get_file_storage_path("MY_SHAREPOINT_FILES"),
  col_types = NULL,
  file_extension = ".xlsx"
)
```

## Arguments

- filename:

  The name of the file, excluding the file extension (e.g. .xlsx)

- sheetname:

  The name or position of the sheet you'd like to read. Defaults to
  position 1.

- skip_rows:

  The number of rows to skip before any data is read from the sheet.
  Default to zero rows skipped.

- path:

  The full directory path to the file. Default to the file path you
  stored in .Renviron as MY_SHAREPOINT_FILES.

- col_types:

  The data type for the column. Default to NULL

- file_extension:

  The file extension of the file. Default to .xlsx files.

## Value

A tibble
