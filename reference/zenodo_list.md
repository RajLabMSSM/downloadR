# List Zenodo files

List all files available in a given Zenodo record. Requires already
having a Zenodo account set up and

## Usage

``` r
zenodo_list(
  concept_doi,
  token = Sys.getenv("zenodo_token"),
  sandbox = FALSE,
  as_datatable = TRUE,
  verbose = TRUE
)
```

## Source

[zen4R
vignette](https://cran.r-project.org/web/packages/zen4R/vignettes/zen4R.html)
[zen4R vignette](https://rpubs.com/antaldaniel/zenodo-sandbox-setup)

## Arguments

- concept_doi:

  Concept DOI of the Zenodo record.

- token:

  Zenodo [Personal access
  token](https://zenodo.org/account/settings/applications/tokens/new/).

- sandbox:

  Whether to use the Zenodo or Zenodo Sandbox API.

- as_datatable:

  Return file info as a
  [data.table](https://rdrr.io/pkg/data.table/man/data.table.html).

- verbose:

  Print messages.

## Value

Nested list of Zenodo file info.

## Examples

``` r
if (FALSE) { # \dontrun{
zen_dat <- zenodo_list(token="<token>",
                       concept_doi="10.5281/zenodo.7062237")
} # }
```
