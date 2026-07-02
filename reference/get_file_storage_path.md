# Retrieve the full path to the local SharePoint directory where your team's files are stored

Retrieve the full path to the local SharePoint directory where your
team's files are stored

## Usage

``` r
get_file_storage_path(
  dir_ref = "MY_SHAREPOINT_FILES",
  renviron_path = here::here(".Renviron")
)
```

## Arguments

- dir_ref:

  The name you assigned for your SharePoint Document Library when you
  called create_environment_variable(), defaults to
  "MY_SHAREPOINT_FILES".

- renviron_path:

  The path to the .Renviron file, defaults to your project's home
  directory.

## Value

A string containing a Windows directory path, or else an error message.

## Examples

``` r
if (FALSE) get_file_storage_path("MY_SHAREPOINT_FILES") # \dontrun{}
```
