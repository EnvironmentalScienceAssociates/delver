
#' Get dataset file
#'
#' Get a specific version of a file from within a DELVE project and dataset
#'
#' @md
#' @param project_id     ProjectID (integer)
#' @param dataset_id     DataSetID (integer)
#' @param version        Version (integer)
#' @param filename       Filename
#' @param user_token     DELVE user token
#' @param use_qa         Boolean flag to use QA version of DELVE
#' @export

get_dataset_file <- function(project_id, dataset_id, version, filename,
                             user_token = get_user_token(), use_qa = FALSE) {
  qa = if (use_qa) "qa." else ""
  glue::glue("https://gateway.{qa}delve.water.ca.gov/api/projects/{project_id}/data-sets/{dataset_id}/versions/{version}/files/{filename}/download") |>
    httr2::request() |>
    httr2::req_headers(`X-DELVE-USER-TOKEN` = get_user_token()) |>
    httr2::req_user_agent("delver (https://github.com/EnvironmentalScienceAssociates/delver)") |>
    httr2::req_perform() |>
    httr2::resp_body_string() |>
    readr::read_csv()
}

#' Get projects
#'
#' Get list of DELVE projects as a dataframe
#'
#' @md
#' @param user_token     DELVE user token
#' @param use_qa         Boolean flag to use QA version of DELVE
#' @export

get_projects <- function(user_token = get_user_token(), use_qa = FALSE) {
  qa = if (use_qa) "qa." else ""
  resp = glue::glue("https://gateway.{qa}delve.water.ca.gov/api/projects-grid-data/") |>
    httr2::request() |>
    httr2::req_headers(`X-DELVE-USER-TOKEN` = get_user_token()) |>
    httr2::req_user_agent("delver (https://github.com/EnvironmentalScienceAssociates/delver)") |>
    httr2::req_perform() |>
    httr2::resp_body_json()

  make_na = function(x){
    # used the double nesting b/c `NULL == ""` returns logical(0)
    if (is.null(x)) NA else if (x == "") NA else x
  }

  df = lapply(resp, function(lst){
    data.frame(ID = make_na(lst[["ID"]]),
               Name = make_na(lst[["Name"]]),
               DatasetTypes = make_na(lst[["DataSetTypesCSV"]]),
               ProjectSteward = make_na(lst[["data-steward-program-manager"]]),
               StartDate = make_na(lst[["start-date"]]),
               EndDate = make_na(lst[["end-date"]]))
  })

  do.call(rbind, df)
}
