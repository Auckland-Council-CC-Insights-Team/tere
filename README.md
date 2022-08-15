
<!-- README.md is generated from README.Rmd. Please edit that file -->

# awhina

<!-- badges: start -->

[![R-CMD-check](https://github.com/lddurbinAC/awhina/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/lddurbinAC/awhina/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

The goal of awhina is to support kaimahi at Auckland Council when they
work with the R programming language.

## Installation

You can install the development version of awhina from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("lddurbinAC/awhina")
```

## Example

This is a basic example which shows you how to install and load the most
useful R packages (known collectively as the tidyverse), and how to
store and retrieve that path to your team’s locally-sync’d SharePoint
Document Library.

``` r
library(awhina)
get_started("tidyverse")
#> ℹ You already have these packages installed. Ka rawe!
#> Warning: package 'tidyverse' was built under R version 4.2.1
#> ── Attaching packages
#> ───────────────────────────────────────
#> tidyverse 1.3.2 ──
#> ✔ ggplot2 3.3.6     ✔ purrr   0.3.4
#> ✔ tibble  3.1.7     ✔ dplyr   1.0.9
#> ✔ tidyr   1.2.0     ✔ stringr 1.4.0
#> ✔ readr   2.1.2     ✔ forcats 0.5.1
#> ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
#> ✖ dplyr::filter() masks stats::filter()
#> ✖ dplyr::lag()    masks stats::lag()
#> ℹ All packages installed and loaded. Happy coding!

create_environment_variable("path/to/my/sharepoint/directory")
#> ℹ Successfully created the .Renviron file to store your directory path.
my_files <- get_file_storage_path()
```
