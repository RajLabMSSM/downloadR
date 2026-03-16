# `load_rdata`

Load processed data (*.rda* format) using a function that assigns it to
a specific variable (so you don't have to guess what the loaded variable
name is). If a *.rda* file is remote and , it will first be downloaded
using
[downloader](https://rajlabmssm.github.io/downloadR/reference/downloader.md).

## Usage

``` r
load_rdata(fileName, ...)
```

## Arguments

- fileName:

  Name of the file to load.

- ...:

  Arguments passed on to
  [`downloader`](https://rajlabmssm.github.io/downloadR/reference/downloader.md)

  `input_url`

  :   URL to remote file.

  `output_dir`

  :   The file directory you want to save the download in.

  `output_path`

  :   The file name you want to save the download as.

  `download_method`

  :   

      `"axel"` :

      :   Multi-threaded

      `"wget"` :

      :   Single-threaded

      `"download.file"` :

      :   Single-threaded

      `"internal"` :

      :   Single-threaded (passed to
          [download.file](https://rdrr.io/r/utils/download.file.html))

      `"wininet"` :

      :   Single-threaded (passed to
          [download.file](https://rdrr.io/r/utils/download.file.html))

      `"libcurl"` :

      :   Single-threaded (passed to
          [download.file](https://rdrr.io/r/utils/download.file.html))

      `"curl"` :

      :   Single-threaded (passed to
          [download.file](https://rdrr.io/r/utils/download.file.html))

  `retry_method`

  :   Method to automatically retry with when the selected
      `download_method` fails.

  `background`

  :   Run in background

  `force_overwrite`

  :   Overwrite existing file.

  `quiet`

  :   Run quietly.

  `show_progress`

  :   show_progress.

  `continue`

  :   continue.

  `nThread`

  :   Number of threads to parallelize over.

  `alternate`

  :   alternate,

  `check_certificates`

  :   check_certificates

  `timeout`

  :   How many seconds before giving up on download. Passed to
      `download.file`. Default: `30*60` (30min).

  `conda_env`

  :   Conda environment to use.

  `verbose`

  :   Print messages.

## Value

R object

## Examples

``` r
if (FALSE) { # \dontrun{
fileName <- paste0("https://github.com/RajLabMSSM/",
"Fine_Mapping_Shiny/raw/master/www/BST1.finemap_DT.RDS")
dat <- load_rdata(fileName)
} # }
```
