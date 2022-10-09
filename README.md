
<!-- README.md is generated from README.Rmd. Please edit that file -->

# tere

<!-- badges: start -->

[![R-CMD-check](https://github.com/lddurbinAC/tere/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/lddurbinAC/tere/actions/workflows/R-CMD-check.yaml)
[![test-coverage](https://github.com/lddurbinAC/tere/actions/workflows/test-coverage.yaml/badge.svg)](https://github.com/lddurbinAC/tere/actions/workflows/test-coverage.yaml)
<!-- badges: end -->

The goal of tere is to support kaimahi at Auckland Council when they
work with the R programming language.

## Installation

You can install the development version of tere from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("lddurbinAC/tere")
```

## Example

This is a basic example which shows you how to install and load the most
useful R packages (known collectively as the tidyverse).

``` r
library(tere)
get_started("tidyverse")
#> ℹ You already have these packages installed. Ka rawe!
#> ── Attaching packages ─────────────────────────────────────── tidyverse 1.3.2 ──
#> ✔ ggplot2 3.3.6      ✔ purrr   0.3.5 
#> ✔ tibble  3.1.8      ✔ dplyr   1.0.10
#> ✔ tidyr   1.2.1      ✔ stringr 1.4.1 
#> ✔ readr   2.1.3      ✔ forcats 0.5.2 
#> ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
#> ✖ dplyr::filter() masks stats::filter()
#> ✖ dplyr::lag()    masks stats::lag()
#> ℹ All packages installed and loaded. Happy coding!
```
