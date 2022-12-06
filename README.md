## delver

R interface to [DELVE](https://dmvs.water.ca.gov/) API based on [`httr` package](https://httr.r-lib.org/).

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

Set DELVE user token. `set_user_token` will open a dialog box if no token is provided. The DELVE user token is found in Workspace under the 'PowerBI Profile' tab.

```
set_user_token()
```

Query DELVE to return a dataset. Components of a query can be extracted from the DELVE url for a given file, e.g., https://dmvs.water.ca.gov/file-details?ProjectID=42&DataSetID=157&Version=1&FileName=EDBPS_collecting-water-quality-data_20210803.csv.

```
df = delve_query(project_id = 42, dataset_id = 157, version = 1,
                 filename = "EDBPS_collecting-water-quality-data_20210803.csv")
```
