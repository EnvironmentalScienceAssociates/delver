% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/delete.R
\name{delete_dataset_file}
\alias{delete_dataset_file}
\title{Delete dataset file}
\usage{
delete_dataset_file(
  project_id,
  dataset_id,
  version,
  filename,
  user_token = get_user_token(),
  use_qa = FALSE
)
}
\arguments{
\item{project_id}{ProjectID (integer)}

\item{dataset_id}{DatasetID (integer)}

\item{version}{Version (integer)}

\item{filename}{Filename}

\item{user_token}{DELVE user token}

\item{use_qa}{Boolean flag to use QA version of DELVE}
}
\description{
Delete a file from within a DELVE project, dataset, and version.
}
