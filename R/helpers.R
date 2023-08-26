#' Convert a Financial Year To A Date
#'
#' @description Given a Financial Year (e.g. "FY24) and a month, convert it to
#'   an actual date.
#'
#'
#' @param fy Character string of Financial Year, expressed either as "FYYY" or
#'   simply "YY".
#' @param month Name of month expressed as unabbreviated character string (e.g.
#'   "August").
#' @param starts Name of the month in which the Financial Year starts, expressed
#'   as unabbreviated character string (e.g. "July").
#' @param day Number expressing the day of the month, expressed as a character
#'   vector. Default is "01".
#'
#' @return An S3 object of class <Date>.
#' @export
#'
#' @examples
#' fy_to_date("FY24", "August", "July")
fy_to_date <- function(fy, month, starts, day = "01") {
  fy_date <- get_fy_date(fy, month, day)

  actual_date <- dplyr::if_else(
    match(month, month.name) >= match(starts, month.name),
    fy_date - lubridate::years(1),
    fy_date
  )

  return(actual_date)
}


#' Format A Financial Year As a Date
#'
#' @param fy Character string of Financial Year, expressed either as "FYYY" or
#'   simply "YY".
#' @param month Name of month expressed as unabbreviated character string (e.g.
#'   "August").
#' @param day Number expressing the day of the month, expressed as a character
#'   vector. Default is "01".
#'
#' @return An S3 object of class <Date>.
#'
#' @noRd
get_fy_date <- function(fy, month, day = "01") {
  year_num <- stringr::str_remove_all(fy, "[^0-9.-]")

  if(stringr::str_length(year_num < 4)) {
    year_num <- paste0("20", year_num)
  }

  fy_date <- as.Date(paste0(year_num, "-", match(month, month.name), "-", day))

  return(fy_date)
}
