
#' Get dataset file
#'
#' Get a file from within a DELVE project, dataset, and version.
#'
#' @md
#' @param project_id     ProjectID (integer)
#' @param dataset_id     DatasetID (integer)
#' @param version        Version (integer)
#' @param filename       Filename
#' @param user_token     DELVE user token
#' @param use_qa         Boolean flag to use QA version of DELVE
#' @export

get_dataset_file <- function(project_id, dataset_id, version, filename,
                             user_token = get_user_token(), use_qa = FALSE) {
  glue::glue("{api_url(use_qa)}/projects/{project_id}/data-sets/{dataset_id}/versions/{version}/files/{filename}/download") |>
    get_delve(user_token) |>
    httr2::resp_body_string() |>
    readr::read_csv()
}

#' Get dataset files metadata
#'
#' Get files metadata from within a DELVE project, dataset, and version.
#'
#' @md
#' @param project_id     ProjectID (integer)
#' @param dataset_id     DatasetID (integer)
#' @param version        Version (integer)
#' @param user_token     DELVE user token
#' @param use_qa         Boolean flag to use QA version of DELVE
#' @export

get_dataset_files <- function(project_id, dataset_id, version,
                              user_token = get_user_token(), use_qa = FALSE) {
  resp = glue::glue("{api_url(use_qa)}/projects/{project_id}/data-sets/{dataset_id}/versions/{version}/files") |>
    get_delve(user_token) |>
    httr2::resp_body_json()

  df_list = lapply(resp, function(lst){
    data.frame(FileID = make_na(lst[["FileID"]]),
               CanonicalName = make_na(lst[["CanonicalName"]]),
               Name = make_na(lst[["Name"]]),
               Path = make_na(lst[["Path"]]),
               PercentComplete = make_na(lst[["PercentComplete"]]),
               PercentClean = make_na(lst[["PercentClean"]]))
  })

  do.call(rbind, df_list)
}
