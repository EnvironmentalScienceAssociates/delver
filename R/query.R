
#' Set or get DELVE API token
#'
#' Set or get DELVE API token as environmental variable in .Renviron
#'
#' @export
set_user_token <- function(token = NULL) {
  if (is.null(token)) {
    token <- askpass::askpass("Please enter your DELVE user token")
  }
  Sys.setenv("DELVEtoken" = token)
}

#' @rdname set_user_token
#' @export
get_user_token <- function() {
  token <- Sys.getenv("DELVEtoken")
  if (!identical(token, "")) {
    return(token)
  } else {
    stop("No DELVE user token found, please supply with `user_token` argument or with DELVEtoken env var")
  }
}

#' Query DELVE API
#'
#' Submit GET request to DELVE API
#'
#' Returns response to DELVE query as a data frame
#'
#' @md
#' @param project_id     ProjectID (integer)
#' @param dataset_id     DataSetID (integer)
#' @param version        Version (integer)
#' @param filename       Filename
#' @param user_token     DELVE user token
#' @export

delve_query <- function(project_id, dataset_id, version, filename,
                          user_token = get_user_token()) {
  query_url = glue::glue("https://gateway.delve.water.ca.gov/api/projects/{project_id}/data-sets/{dataset_id}/versions/{version}/files/{filename}/download")
  resp <- httr::GET(url = query_url, config = httr::add_headers(`X-DELVE-USER-TOKEN` = user_token),
                    httr::user_agent("delver (https://github.com/EnvironmentalScienceAssociates/delver)"))
  status <- httr::http_status(resp)
  if (status$category == "Success") {
    return(httr::content(resp, as = "parsed", type = "text/csv"))
  } else {
    stop("Query unsuccessful")
  }
}


