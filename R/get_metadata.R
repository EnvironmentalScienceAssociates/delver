
#' Get metadata
#'
#' Get DELVE metadata for projects, datasets, dataset types, file types, and keywords.
#'
#' @md
#' @param user_token     DELVE user token
#' @param use_qa         Boolean flag to use QA version of DELVE
#' @export

get_projects <- function(user_token = get_user_token(), use_qa = FALSE) {
  resp = glue::glue("{api_url(use_qa)}projects-grid-data") |>
    get_delve(user_token) |>
    httr2::resp_body_json()

  df_list = lapply(resp, function(lst){
    data.frame(ProjectID = make_na(lst[["ID"]]),
               ProjectName = make_na(lst[["Name"]]),
               DatasetTypes = make_na(lst[["DataSetTypesCSV"]]),
               ProjectSteward = make_na(lst[["data-steward-program-manager"]]),
               StartDate = make_na(lst[["start-date"]]),
               EndDate = make_na(lst[["end-date"]]))
  })

  do.call(rbind, df_list)
}

#' @rdname get_projects
#' @export
get_datasets <- function(user_token = get_user_token(), use_qa = FALSE) {
  resp = glue::glue("{api_url(use_qa)}data-sets-grid-data") |>
    get_delve(user_token) |>
    httr2::resp_body_json()

  df_list = lapply(resp, function(lst){
    data.frame(ProjectID = make_na(lst[["ProjectID"]]),
               DatasetID = make_na(lst[["ID"]]),
               DatasetName = make_na(lst[["Name"]]),
               DatasetType = make_na(lst[["TypeName"]]),
               Status = make_na(lst[["LatestVersionStatusName"]]),
               CreatedBy = make_na(lst[["CreateUserFullName"]]),
               LastUpdated = make_na(lst[["UpdateDate"]]),
               LatestVersion = make_na(lst[["LatestVersion"]]))
  })

  do.call(rbind, df_list)
}

#' @rdname get_projects
#' @export
get_dataset_types <- function(user_token = get_user_token(), use_qa = FALSE) {
  resp = glue::glue("{api_url(use_qa)}data-set-types") |>
    get_delve(user_token) |>
    httr2::resp_body_json()

  df_list = lapply(resp, function(lst){
    data.frame(DataSetTypeID = make_na(lst[["DataSetTypeID"]]),
               CanonicalName = make_na(lst[["CanonicalName"]]),
               Name = make_na(lst[["Name"]]),
               DataSetCount = make_na(lst[["DataSetCount"]]))
  })

  do.call(rbind, df_list)
}

#' @rdname get_projects
#' @export
get_file_types <- function(user_token = get_user_token(), use_qa = FALSE) {
  resp = glue::glue("{api_url(use_qa)}file-types") |>
    get_delve(user_token) |>
    httr2::resp_body_json()

  df_list = lapply(resp, function(lst){
    data.frame(FileTypeID = make_na(lst[["FileTypeID"]]),
               CanonicalName = make_na(lst[["CanonicalName"]]),
               Name = make_na(lst[["Name"]]))
  })

  do.call(rbind, df_list)
}

#' @rdname get_projects
#' @export
get_keywords <- function(user_token = get_user_token(), use_qa = FALSE) {
  glue::glue("{api_url(use_qa)}keywords") |>
    get_delve(user_token) |>
    httr2::resp_body_json() |>
    unlist() |>
    unique() |>
    sort()
}

# Private Functions -------------------------------------------------------

api_url <- function(use_qa){
  # returns base url
  qa = if (use_qa) "qa." else ""
  glue::glue("https://gateway.{qa}delve.water.ca.gov/api/")
}

get_delve <- function(url, user_token){
  # core elements of a DELVE get request
  httr2::request(url) |>
    httr2::req_headers(`X-DELVE-USER-TOKEN` = user_token) |>
    httr2::req_user_agent("delver (https://github.com/EnvironmentalScienceAssociates/delver)") |>
    httr2::req_perform()
}

make_na <- function(x){
  # used the double nesting b/c `NULL == ""` returns logical(0)
  if (is.null(x)) NA else if (x == "") NA else x
}
