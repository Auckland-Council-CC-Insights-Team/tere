% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_started.R
\name{get_started}
\alias{get_started}
\title{Load packages}
\usage{
get_started(package_names)
}
\arguments{
\item{package_names}{a character vector of package names.}
}
\value{
A stylised message in the console.
}
\description{
Given a list of package names, append the purrr package to the list then check if they're all
installed (install them if not). Afterwards, load the packages via library().
}
\examples{
get_started(c("dplyr", "lubridate"))
}
