# downloader wrapper

R wrapper for `"axel"` (multi-threaded) and `"download.file"`
(single-threaded) download functions.

## Usage

``` r
downloader(
  input_url,
  output_dir = tempdir(),
  output_path = file.path(output_dir, basename(input_url)),
  download_method = c("axel", "wget", "download.file", "internal", "wininet", "libcurl",
    "curl"),
  retry_method = "download.file",
  background = FALSE,
  force_overwrite = FALSE,
  quiet = TRUE,
  show_progress = TRUE,
  continue = TRUE,
  alternate = TRUE,
  check_certificates = TRUE,
  timeout = 5 * 60,
  conda_env = "echoR_mini",
  nThread = 1,
  verbose = TRUE
)
```

## Arguments

- input_url:

  URL to remote file.

- output_dir:

  The file directory you want to save the download in.

- output_path:

  The file name you want to save the download as.

- download_method:

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

- retry_method:

  Method to automatically retry with when the selected `download_method`
  fails.

- background:

  Run in background

- force_overwrite:

  Overwrite existing file.

- quiet:

  Run quietly.

- show_progress:

  show_progress.

- continue:

  continue.

- alternate:

  alternate,

- check_certificates:

  check_certificates

- timeout:

  How many seconds before giving up on download. Passed to
  `download.file`. Default: `30*60` (30min).

- conda_env:

  Conda environment to use.

- nThread:

  Number of threads to parallelize over.

- verbose:

  Print messages.

## Value

Local path to downloaded file.

Named vector of files, where the names are the URLs and the values are
the paths to the respective local files.

## See also

Other downloaders:
[`aws()`](https://rajlabmssm.github.io/downloadR/reference/aws.md),
[`axel()`](https://rajlabmssm.github.io/downloadR/reference/axel.md),
[`wget()`](https://rajlabmssm.github.io/downloadR/reference/wget.md)

## Examples

``` r
if (FALSE) { # \dontrun{
input_url <- paste(
    "https://github.com/RajLabMSSM/Fine_Mapping",
    "raw/master/Data/lead.SNP.coords.csv", sep="/")
output_paths <- downloadR::downloader(input_url = input_url)
} # }
```
