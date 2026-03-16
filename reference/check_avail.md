# Check tool availability

Check whether a tool is installed and usable from the command line by
simply invoking its name. If not, will try to find an executable of the
tool via the specified `conda_env`. Finally, if no executable can be
found, will simply return `NULL`.

## Usage

``` r
check_avail(tool, conda_env = "echoR_mini", verbose = TRUE)
```

## Arguments

- tool:

  Tool name, or full path to tool executable.

- conda_env:

  Conda environments to search in. If `NULL` (default), will search all
  conda environments.

- verbose:

  Print messages.
