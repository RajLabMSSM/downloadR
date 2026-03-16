# Download a remote VCF file and its index file

Download a remote VCF file and its index file

## Usage

``` r
download_vcf(
  vcf_url,
  vcf_dir = tempdir(),
  download_method = "download.file",
  force_new = FALSE,
  quiet = TRUE,
  nThread = 1
)
```

## Arguments

- vcf_url:

  Remote URL to VCF file.

- vcf_dir:

  Where to download VCF file.

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

- force_new:

  Overwrite a previously downloaded VCF with the same path name.

- quiet:

  Run quietly.

- nThread:

  Number of threads to parallelize over.

## Value

List containing the paths to the downloaded VCF and its index file.

## Examples

``` r
if (FALSE) { # \dontrun{
vcf_url <- "https://gwas.mrcieu.ac.uk/files/ieu-a-298/ieu-a-298.vcf.gz"
out_paths <- download_vcf(vcf_url = vcf_url)
} # }
```
