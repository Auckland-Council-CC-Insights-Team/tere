#' Connect To A SharePoint Site
#'
#' @param site_name The name of the SharePoint site to which you wish to
#'   connect, which can be found in the site's homepage URL.
#'
#' @return An R6 object of class ms_site.
#'
#' @export
connect_to_sharepoint <- function(site_name) {
  withr::local_options(list(
    microsoft365r_use_cli_app_id = TRUE,
    warn = -1
  ))

  sharepoint_site <- Microsoft365R::get_sharepoint_site(
    site_url = paste0("https://aklcouncil.sharepoint.com/sites/", site_name),
    app="04b07795-8ddb-461a-bbee-02f9e1bf7b46"
  )

  return(sharepoint_site)
}


#' Retrieve SharePoint List Items
#'
#' @param site_name The name of the SharePoint site to which you wish to
#'   connect, which can be found in the site's homepage URL.
#' @param list_name The name of the SharePoint List you wish to retrieve.
#'
#' @return A data frame.
#'
#' @export
get_list_items <- function(site_name, list_name) {
  sharepoint_site <- connect_to_sharepoint(site_name)

  sharepoint_list <- sharepoint_site$get_list(list_name)

  list_items <- sharepoint_list$list_items() |>
    get_tidy_table()

  return(list_items)
}


#' Update SharePoint List Items
#'
#' @param site_name Name of SharePoint site to which you want to connect.
#' @param list_name Name of the List to which you are connecting.
#' @param item_ids Character vector containing a list of IDs to SharePoint List items.
#' @param ... Named character vector.
#'
#' @return Message to the console
#' @export
update_list_items <- function(site_name, list_name, item_ids, ...){
  sharepoint_site <- connect_to_sharepoint(site_name)

  sharepoint_list <- sharepoint_site$get_list(list_name)

  purrr::walk(
    .x = item_ids,
    .f = ~sharepoint_list$update_item(id = .x, ...)
   )
}
