# Create a .Renviron file that points to your locally-synchronised SharePoint Document Library

Given a path to your locally-sync'd SharePoint Document Library, create
a .Renviron file in the project root to store that information for
future reference.

## Usage

``` r
create_environment_variable(dir_ref = "MY_SHAREPOINT_FILES")
```

## Arguments

- dir_ref:

  A name for your SharePoint Document Library, using only capital
  letters and no spaces. Defaults to "MY_SHAREPOINT_FILES".

## Value

A stylised message in the console.

## Examples

``` r
if (FALSE) create_environment_variable("MY_SHAREPOINT_FILES") # \dontrun{}
```
