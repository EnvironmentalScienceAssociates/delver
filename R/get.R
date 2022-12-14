
#' Get dataset file
#'
#' Get a specific version of a file from within a DELVE project and dataset
#'
#'
#' @md
#' @param project_id     ProjectID (integer)
#' @param dataset_id     DataSetID (integer)
#' @param version        Version (integer)
#' @param filename       Filename
#' @param user_token     DELVE user token
#' @export

get_dataset_file <- function(project_id, dataset_id, version, filename, user_token = get_user_token()) {
  glue::glue("https://gateway.delve.water.ca.gov/api/projects/{project_id}/data-sets/{dataset_id}/versions/{version}/files/{filename}/download") |>
    httr2::request() |>
    httr2::req_headers(`X-DELVE-USER-TOKEN` = get_user_token()) |>
    httr2::req_user_agent("delver (https://github.com/EnvironmentalScienceAssociates/delver)") |>
    httr2::req_perform() |>
    httr2::resp_body_string() |>
    readr::read_csv()
}


