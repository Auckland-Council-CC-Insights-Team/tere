test_that("a Financial Year and month is formatted as its date", {
  expect_equal(get_fy_date("FY24", "August"), as.Date("2024-08-01"))

  expect_equal(get_fy_date("24", "August"), as.Date("2024-08-01"))
})


test_that("a Financial Year and month is converted to an actual date", {
  expect_equal(fy_to_date("FY24", "August", "July"), as.Date("2023-08-01"))
})
