## delver

R interface to components of the [DELVE](https://dmvs.water.ca.gov/) API based on [`httr2` package](https://httr2.r-lib.org/).

### Prerequisites

Installation requires the R package [`remotes`](https://remotes.r-lib.org).

```
install.packages("remotes")
```

### Installation

`delver` is only available through GitHub.

```
remotes::install_github("EnvironmentalScienceAssociates/delver")
```

### Usage

Load package.

```
library(delver)
```

Set DELVE user token. `set_user_token` will open a dialog box if no token is provided. To avoid setting the token every time, add `X-DELVE-USER-TOKEN=put_your_unique_token_here` to the .Renviron file. If you are new to editing the .Renviron file, see [`usethis::edit_r_environ()`](https://usethis.r-lib.org/reference/edit.html).

The DELVE user token is found on DELVE in Workspace under the 'PowerBI Profile' tab.

```
set_user_token()
```

Get metadata for datasets and projects.

```
projects = get_projects()
datasets = get_datasets()
```

Get a specific version of a file from within a DELVE project and dataset.

```
df = get_dataset_file(project_id = 42, dataset_id = 157, version = 1,
                      filename = "EDBPS_collecting-water-quality-data_20210803.csv")
```
