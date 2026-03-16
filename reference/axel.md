# axel downloader

R wrapper for axel, which enables multi-threaded download of a single
large file.

## Usage

``` r
axel(
  input_url,
  output_path,
  axel_path = "axel",
  background = FALSE,
  force_overwrite = FALSE,
  quiet = TRUE,
  alternate = TRUE,
  check_certificates = FALSE,
  conda_env = "echoR_mini",
  nThread = 1,
  verbose = TRUE
)
```

## Arguments

- input_url:

  URL to remote file.

- output_path:

  The file name you want to save the download as.

- background:

  Run in background

- force_overwrite:

  Overwrite existing file.

- quiet:

  Run quietly.

- alternate:

  alternate,

- check_certificates:

  check_certificates

- conda_env:

  Conda environment to use.

- nThread:

  Number of threads to parallelize over.

- verbose:

  Print messages.

## Value

Path where the file has been downloaded

## See also

<https://github.com/axel-download-accelerator/axel/>

Other downloaders:
[`aws()`](https://rajlabmssm.github.io/downloadR/reference/aws.md),
[`downloader()`](https://rajlabmssm.github.io/downloadR/reference/downloader.md),
[`wget()`](https://rajlabmssm.github.io/downloadR/reference/wget.md)
