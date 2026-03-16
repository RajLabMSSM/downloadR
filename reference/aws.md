# AWS downloader

AWS S3 bucket downloader.

## Usage

``` r
aws(
  input_url,
  output_path = file.path(tempdir(), basename(input_url)),
  bucket,
  force_overwrite = FALSE,
  verbose = TRUE,
  ...
)
```

## Arguments

- input_url:

  URL to remote file.

- output_path:

  The file name you want to save the download as.

- bucket:

  Character string with the name of the bucket, or an object of class
  “s3_bucket”.

- force_overwrite:

  Overwrite existing file.

- verbose:

  Print messages.

- ...:

  Arguments passed on to
  [`aws.s3::save_object`](https://rdrr.io/pkg/aws.s3/man/get_object.html)

  `object`

  :   Character string with the object key, or an object of class
      “s3_object”. In most cases, if `object` is specified as the
      latter, `bucket` can be omitted because the bucket name will be
      extracted from “Bucket” slot in `object`.

  `headers`

  :   List of request headers for the REST call.

  `file`

  :   An R connection, or file name specifying the local file to save
      the object into.

  `overwrite`

  :   A logical indicating whether to overwrite `file`. Passed to
      [`write_disk`](https://httr.r-lib.org/reference/write_disk.html).
      Default is `TRUE`.

## Value

Path where the file has been downloaded

## See also

<https://blog.djnavarro.net/posts/2022-03-17_using-aws-s3-in-r/>

Other downloaders:
[`axel()`](https://rajlabmssm.github.io/downloadR/reference/axel.md),
[`downloader()`](https://rajlabmssm.github.io/downloadR/reference/downloader.md),
[`wget()`](https://rajlabmssm.github.io/downloadR/reference/wget.md)

## Examples

``` r
if (FALSE) { # \dontrun{
bucket <- "s3://broad-alkesgroup-ukbb-ld/"
input_url <- "UKBB_LD/chr10_135000001_138000001.gz"
out <- aws(input_url = input_url, bucket = bucket)
} # }
```
