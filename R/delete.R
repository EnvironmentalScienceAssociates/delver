
#' Delete dataset file
#'
#' Delete a file from within a DELVE project, dataset, and version.
#'
#' @md
#' @param project_id     ProjectID (integer)
#' @param dataset_id     DatasetID (integer)
#' @param version        Version (integer)
#' @param filename       Filename
#' @param user_token     DELVE user token
#' @param use_qa         Boolean flag to use QA version of DELVE
#' @export

delete_dataset_file <- function(project_id, dataset_id, version, filename,
                                user_token = get_user_token(), use_qa = FALSE) {
  glue::glue("{api_url(use_qa)}/projects/{project_id}/data-sets/{dataset_id}/versions/{version}/files/{filename}") |>
    delete_delve(user_token)
}

# Private Functions -------------------------------------------------------

delete_delve <- function(url, user_token){
  # core elements of a DELVE delete request
  httr2::request(url) |>
    httr2::req_method("DELETE") |>
    httr2::req_headers(`X-DELVE-USER-TOKEN` = user_token) |>
    httr2::req_user_agent("delver (https://github.com/EnvironmentalScienceAssociates/delver)") |>
    httr2::req_perform()
}


