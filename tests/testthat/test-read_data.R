test_that("file names in a folder are returned", {


  expect_equal(
    get_file_name(test_path(), "/testdata")
    , paste0("testdata/",
             c("mtcars")
    )
  )
})
