# wget

R wrapper for wget

## Usage

``` r
wget(
  input_url,
  output_path,
  wget_path = "wget",
  background = TRUE,
  force_overwrite = FALSE,
  quiet = FALSE,
  show_progress = TRUE,
  continue = TRUE,
  check_certificates = FALSE,
  conda_env = "echoR_mini",
  verbose = TRUE
)
```

## Value

Local path to downloaded file.

## See also

Other downloaders:
[`aws()`](https://rajlabmssm.github.io/downloadR/reference/aws.md),
[`axel()`](https://rajlabmssm.github.io/downloadR/reference/axel.md),
[`downloader()`](https://rajlabmssm.github.io/downloadR/reference/downloader.md)
