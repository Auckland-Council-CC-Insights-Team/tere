test_that("get_file_storage_path works", {
  # .Renviron holds the expected environment variable(s)
  withr::with_tempfile(".Renviron",{
    writeLines("SHAREPOINT_FILE_STORAGE='path/to/files'", .Renviron);
    expect_identical(get_file_storage_path("SHAREPOINT_FILE_STORAGE", .Renviron), "path/to/files")
  })
})


test_that("a data frame is converted to a tibble with clean column names", {
  L3 <- LETTERS[1:3]
  char <- sample(L3, 10, replace = TRUE)

  data <- data.frame(
    "Column One" = 1,
    "Column Two" = 1:10,
    "Column Three" = char,
    check.names = FALSE
  )

  expect_equal(
    names(get_tidy_table(data)),
    c("column_one", "column_two", "column_three")
  )
})
