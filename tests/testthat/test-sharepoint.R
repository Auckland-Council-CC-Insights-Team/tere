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
