
#' Set or get DELVE API token
#'
#' Set or get DELVE API token as environmental variable
#'
#' @param user_token     DELVE user token
#'
#' @export
set_user_token <- function(user_token = NULL) {
  if (is.null(user_token)) {
    token <- askpass::askpass("Please enter your DELVE user token")
  }
  Sys.setenv("X-DELVE-USER-TOKEN" = user_token)
}

#' @rdname set_user_token
#' @export
get_user_token <- function() {
  user_token <- Sys.getenv("X-DELVE-USER-TOKEN")
  if (!identical(user_token, "")) {
    return(user_token)
  } else {
    stop("No DELVE user token found, please supply with `user_token` argument or with
         X-DELVE-USER-TOKEN environmental variable in .Renviron.")
  }
}
