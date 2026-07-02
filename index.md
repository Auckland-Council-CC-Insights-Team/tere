# tere

The goal of tere is to support kaimahi at Auckland Council when they
work with the R programming language.

## Installation

You can install the development version of tere from
[GitHub](https://github.com/) with:

``` r

# install.packages("remotes")
remotes::install_github("Auckland-Council-CC-Insights-Team/tere")
```

## Example

This is a basic example which shows you how to quickly read an Excel
file:

``` r

library(tere)
get_excel_file("my_excel_file", "sheet_name")
```
