# Convert a Financial Year To A Date

Given a Financial Year (e.g. "FY24) and a month, convert it to an actual
date.

## Usage

``` r
fy_to_date(fy, month, starts, day = "01")
```

## Arguments

- fy:

  Character string of Financial Year, expressed either as "FYYY" or
  simply "YY".

- month:

  Name of month expressed as unabbreviated character string (e.g.
  "August").

- starts:

  Name of the month in which the Financial Year starts, expressed as
  unabbreviated character string (e.g. "July").

- day:

  Number expressing the day of the month, expressed as a character
  vector. Default is "01".

## Value

An S3 object of class .

## Examples

``` r
fy_to_date("FY24", "August", "July")
#> [1] "2023-08-01"
```
