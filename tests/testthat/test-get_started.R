# cli::test_that_cli(configs = c("plain"), "check_renviron works", {
#   # .Renviron exists and "renviron_path" points to correct path
#   withr::with_tempfile(".Renviron",{
#     writeLines("", .Renviron);
#     expect_snapshot(check_renviron(.Renviron))
#   })
#
#   # .Renviron may exist but "renviron_path" points to incorrect path
#   expect_snapshot(check_renviron("fake/path"))
# })
#
# test_that("check_environment_variable works", {
#   expect_false(check_environment_variable("NON_EXISTENT_VARIABLE"))
# })
#
# cli::test_that_cli(configs = c("plain"), "get_renviron works", {
#   # .Renviron holds the expected environment variable(s)
#   withr::with_envvar(
#     new = c("EXPECTED_VARIABLE" = "a value"),
#     expect_identical(get_renviron("EXPECTED_VARIABLE"), "a value")
#     )
#
#   # .Renviron does not hold the expected environment variable(s)
#   withr::with_envvar(
#     new = c("UNEXPECTED_VARIABLE" = "a value"),
#     expect_snapshot(get_renviron("EXPECTED_VARIABLE"))
#   )
# })

test_that("get_file_storage_path works", {
  # .Renviron holds the expected environment variable(s)
  withr::with_tempfile(".Renviron",{
    writeLines("SHAREPOINT_FILE_STORAGE='path/to/files'", .Renviron);
    expect_identical(get_file_storage_path("SHAREPOINT_FILE_STORAGE", .Renviron), "path/to/files")
  })
})
