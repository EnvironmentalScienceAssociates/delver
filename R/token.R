
#' Set or get DELVE API token
#'
#' Set or get DELVE API token as environmental variable
#'
#' @export
set_user_token <- function(token = NULL) {
  if (is.null(token)) {
    token <- askpass::askpass("Please enter your DELVE user token")
  }
  Sys.setenv("X-DELVE-USER-TOKEN" = token)
}

#' @rdname set_user_token
#' @export
get_user_token <- function() {
  token <- Sys.getenv("X-DELVE-USER-TOKEN")
  if (!identical(token, "")) {
    return(token)
  } else {
    stop("No DELVE user token found, please supply with `user_token` argument or with
         X-DELVE-USER-TOKEN environmental variable in .Renviron.")
  }
}
