# check_renviron works [plain]

    Code
      check_renviron(.Renviron)
    Message <cliMessage>
      i You have a .Renviron file! Reading it now...

---

    Code
      check_renviron("fake/path")
    Message <cliMessage>
      ! You do not have a .Renviron file, or you passed the incorrect directory path.
      ! Please call create_environment_variable('MY_SHAREPOINT_FILES') and pass the path to your SharePoint directory when prompted.

# get_renviron works [plain]

    Code
      get_renviron("EXPECTED_VARIABLE")
    Message <cliMessage>
      ! You have a .Renviron file but the following environment variables are missing: EXPECTED_VARIABLE
      ! Please call create_environment_variable('MY_SHAREPOINT_FILES') and pass, for example, the path to your SharePoint directory when prompted.

