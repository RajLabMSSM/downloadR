# List Figshare files

List links to all downloadable files within a Figshare repository.

## Usage

``` r
figshare_list(id, suffix = NULL, as_datatable = TRUE, verbose = TRUE)
```

## Arguments

- id:

  Figshare repo ID.

- suffix:

  Filter results by file suffixes. Set to `NULL` to return all files
  (default).

- as_datatable:

  Return the return as a
  [data.table](https://rdrr.io/pkg/data.table/man/data.table.html)
  (default: `TRUE`), instead of a nested list (`FALSE`).

- verbose:

  Print messages.

## Examples

``` r
if (FALSE) { # \dontrun{
files <- figshare_list(id="14703003", suffix=c(".RDS","cell_Info.txt"))
} # }
```
