# Getting Started

``` r

library(downloadR)
```

## Introduction

`downloadR` is an echoverse module that provides single- and
multi-threaded downloading functions for R. It wraps several download
backends including
[axel](https://github.com/axel-download-accelerator/axel)
(multi-threaded), `wget`, and R’s built-in `download.file`. It also
provides convenience functions for working with AWS S3, Figshare, and
Zenodo repositories.

## Download files

### Multi-threaded

The core function
[`downloader()`](https://rajlabmssm.github.io/downloadR/reference/downloader.md)
supports a variety of download backends. For multi-threaded downloads of
a single file, use the `axel` method.

``` r

input_url <- paste(
    "https://github.com/RajLabMSSM/Fine_Mapping",
    "raw/master/Data/lead.SNP.coords.csv", sep = "/")
out_path <- downloadR::downloader(input_url = input_url,
                                  download_method = "download.file",
                                  nThread = 1)
#> Downloading with download.file.
#> download.file download successful.
#> Time difference of 0.1 secs
csv <- utils::read.csv(out_path)
knitr::kable(head(csv))
```

| Gene   | lead.SNP   | CHR |       POS |   min.POS |   max.POS |
|:-------|:-----------|----:|----------:|----------:|----------:|
| ASXL3  | rs1941685  |  18 |  31304318 |  30304318 |  32304318 |
| CAMK2D | rs13117519 |   4 | 114369065 | 113369065 | 115369065 |
| DNAH17 | rs666463   |  17 |  76425480 |  75425480 |  77425480 |
| ELOVL7 | rs1867598  |   5 |  60137959 |  59137959 |  61137959 |
| FCGR2A | rs6658353  |   1 | 161469054 | 160469054 | 162469054 |
| HIP1R  | rs10847864 |  12 | 123326598 | 122326598 | 124326598 |

### Single-threaded

For single-threaded downloads, you can use `wget` or `download.file`.

``` r

out_path2 <- downloadR::downloader(input_url = input_url,
                                   download_method = "download.file",
                                   force_overwrite = TRUE)
#> Downloading with download.file.
#> download.file download successful.
#> Time difference of 0.1 secs
```

## Download VCF

[`download_vcf()`](https://rajlabmssm.github.io/downloadR/reference/download_vcf.md)
is a specialised function for downloading Variant Call Format (VCF)
files. It automatically attempts to download both the VCF and its tabix
index file (`.tbi`), if available.

``` r

vcf_url <- "https://gwas.mrcieu.ac.uk/files/ieu-a-298/ieu-a-298.vcf.gz"
out_paths <- downloadR::download_vcf(vcf_url = vcf_url)
```

## Load R data

[`load_rdata()`](https://rajlabmssm.github.io/downloadR/reference/load_rdata.md)
is a convenience function that can read `.rda`, `.rdata`, or `.rds`
files from either a local or remote path. Remote files are downloaded
automatically before loading.

``` r

fileName <- paste0(
    "https://github.com/RajLabMSSM/",
    "Fine_Mapping_Shiny/raw/master/www/BST1.finemap_DT.RDS")
dat <- downloadR::load_rdata(fileName)
knitr::kable(head(dat, 3))
```

| SNP | Locus | CHR | POS | P | Effect | StdErr | A1 | A2 | Freq | MAF | N_cases | N_controls | proportion_cases | N | t_stat | leadSNP | ABF.CS | ABF.PP | SUSIE.CS | SUSIE.PP | POLYFUN_SUSIE.CS | POLYFUN_SUSIE.PP | FINEMAP.CS | FINEMAP.PP | Support | Consensus_SNP | mean.PP | mean.CS | Mb | rs4698412 | rs4698412.1 | r2 |
|:---|:---|---:|---:|---:|---:|---:|:---|:---|---:|---:|---:|---:|---:|---:|---:|:---|---:|---:|---:|---:|---:|---:|---:|---:|---:|:---|---:|---:|---:|---:|---:|---:|
| rs10000290 | BST1 | 4 | 15753299 | 0.00000 | 0.0781 | 0.0133 | A | G | 0.8516 | 0.1484 | 56306 | 1417791 | 0.0382 | 216621 | 5.872180 | FALSE | NA | NA | 0 | 0 | 0 | 0 | NA | NA | 0 | FALSE | 0 | 0 | 15.75330 | -0.4310783 | -0.4310783 | 0.1858285 |
| rs10001565 | BST1 | 4 | 15722573 | 0.00000 | -0.0968 | 0.0160 | T | C | 0.0969 | 0.0969 | 56306 | 1417791 | 0.0382 | 216621 | -6.050000 | FALSE | NA | NA | 0 | 0 | 0 | 0 | NA | NA | 0 | FALSE | 0 | 0 | 15.72257 | -0.3271923 | -0.3271923 | 0.1070548 |
| rs10003136 | BST1 | 4 | 15756300 | 0.03985 | -0.0828 | 0.0403 | A | G | 0.0159 | 0.0159 | 56306 | 1417791 | 0.0382 | 216621 | -2.054591 | FALSE | NA | NA | 0 | 0 | 0 | 0 | NA | NA | 0 | FALSE | 0 | 0 | 15.75630 | -0.0935475 | -0.0935475 | 0.0087511 |

## AWS S3

The [`aws()`](https://rajlabmssm.github.io/downloadR/reference/aws.md)
function downloads files from Amazon S3 buckets using the `aws.s3`
package.

``` r

bucket <- "s3://broad-alkesgroup-ukbb-ld/"
input_url <- "UKBB_LD/chr10_135000001_138000001.gz"
out <- downloadR::aws(input_url = input_url, bucket = bucket)
```

## Figshare

### List files

[`figshare_list()`](https://rajlabmssm.github.io/downloadR/reference/figshare_list.md)
queries the Figshare API to list all downloadable files in a repository.

``` r

files <- downloadR::figshare_list(id = "14703003")
#> Searching for files in Figshare repo: 14703003
#> 18 file(s) found.
knitr::kable(files[, c("name", "size")])
```

| name                                 |       size |
|:-------------------------------------|-----------:|
| Drosophila_Fig1_adata.h5ad           |  573704560 |
| Drosophila_Fig1_cell_Info.txt        |   13339268 |
| Drosophila_Fig1_cluster_marker.xlsx  |     396140 |
| Drosophila_sFig4_dge.RDS             |  339265739 |
| Drosophila_sFig4_cell_Info.txt       |    3736961 |
| Drosophila_sFig4_cluster_marker.xlsx |    1585777 |
| Zebrafish_Fig1_adata.h5ad            | 1031370948 |
| Zebrafish_Fig1_cell_Info.txt         |   32826370 |
| Zebrafish_Fig1_cluster_marker.xlsx   |     366195 |
| Zebrafish_sFig4_dge.RDS              | 1017934396 |
| Zebrafish_sFig4_cell_Info.txt        |   12414742 |
| Zebrafish_sFig4_cluster_marker.xlsx  |    2727132 |
| Earthworm_sFig1_dge.RDS              |   81109685 |
| Earthworm_sFig1_cell_Info.txt        |    4738083 |
| Earthworm_sFig1_cluster_marker.xlsx  |     235485 |
| Earthworm_sFig4_dge.RDS              |   39215464 |
| Earthworm_sFig4_cell_Info.txt        |    1440919 |
| Earthworm_sFig4_cluster_marker.xlsx  |     306317 |

### Download files

[`figshare_download()`](https://rajlabmssm.github.io/downloadR/reference/figshare_download.md)
combines listing and downloading into one step.

``` r

files <- downloadR::figshare_download(
    id = "14703003",
    suffix = "Earthworm_sFig1_cluster_marker.xlsx")
```

## Zenodo

### List files

[`zenodo_list()`](https://rajlabmssm.github.io/downloadR/reference/zenodo_list.md)
retrieves metadata for all files in a Zenodo record. Requires a Zenodo
personal access token (set via the `zenodo_token` environment variable
or passed directly).

``` r

zen_dat <- downloadR::zenodo_list(
    token = "<your-token>",
    concept_doi = "10.5281/zenodo.7062237")
```

### Upload files

[`zenodo_upload()`](https://rajlabmssm.github.io/downloadR/reference/zenodo_upload.md)
creates a new Zenodo record, uploads files, and publishes.

``` r

files <- sapply(seq_len(3), function(i) {
    tmp <- tempfile(fileext = ".txt")
    writeLines(letters, tmp)
    return(tmp)
})
zout <- downloadR::zenodo_upload(
    files = files,
    title = "test_repo")
```

## Session Info

``` r

utils::sessionInfo()
#> R Under development (unstable) (2026-03-12 r89607)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.4 LTS
#> 
#> Matrix products: default
#> BLAS:   /usr/lib/x86_64-linux-gnu/openblas-pthread/libblas.so.3 
#> LAPACK: /usr/lib/x86_64-linux-gnu/openblas-pthread/libopenblasp-r0.3.26.so;  LAPACK version 3.12.0
#> 
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C              
#>  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=en_US.UTF-8    
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8   
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C                 
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C            
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C       
#> 
#> time zone: UTC
#> tzcode source: system (glibc)
#> 
#> attached base packages:
#> [1] stats     graphics  grDevices utils     datasets  methods   base     
#> 
#> other attached packages:
#> [1] downloadR_1.0.0  BiocStyle_2.39.0
#> 
#> loaded via a namespace (and not attached):
#>  [1] dir.expiry_1.19.0     xfun_0.56             bslib_0.10.0         
#>  [4] htmlwidgets_1.6.4     lattice_0.22-9        tzdb_0.5.0           
#>  [7] vctrs_0.7.1           tools_4.6.0           generics_0.1.4       
#> [10] curl_7.0.0            parallel_4.6.0        tibble_3.3.1         
#> [13] pkgconfig_2.0.3       R.oo_1.27.1           Matrix_1.7-4         
#> [16] data.table_1.18.2.1   desc_1.4.3            lifecycle_1.0.5      
#> [19] stringr_1.6.0         compiler_4.6.0        textshaping_1.0.5    
#> [22] echodata_1.0.0        htmltools_0.5.9       sass_0.4.10          
#> [25] yaml_2.3.12           pkgdown_2.2.0         pillar_1.11.1        
#> [28] jquerylib_0.1.4       tidyr_1.3.2           R.utils_2.13.0       
#> [31] aws.s3_0.3.22         DT_0.34.0             cachem_1.1.0         
#> [34] basilisk_1.23.0       tidyselect_1.2.1      zip_2.3.3            
#> [37] digest_0.6.39         stringi_1.8.7         purrr_1.2.1          
#> [40] dplyr_1.2.0           bookdown_0.46         fastmap_1.2.0        
#> [43] grid_4.6.0            cli_3.6.5             magrittr_2.0.4       
#> [46] piggyback_0.1.5       base64enc_0.1-6       aws.signature_0.6.0  
#> [49] readr_2.2.0           filelock_1.0.3        rmarkdown_2.30       
#> [52] httr_1.4.8            otel_0.2.0            reticulate_1.45.0    
#> [55] ragg_1.5.1            png_0.1-8             R.methodsS3_1.8.2    
#> [58] hms_1.1.4             openxlsx_4.2.8.1      echoconda_1.0.0      
#> [61] memoise_2.0.1         evaluate_1.0.5        knitr_1.51           
#> [64] basilisk.utils_1.23.1 rlang_1.1.7           Rcpp_1.1.1           
#> [67] glue_1.8.0            BiocManager_1.30.27   xml2_1.5.2           
#> [70] jsonlite_2.0.0        R6_2.6.1              systemfonts_1.3.2    
#> [73] fs_1.6.7
```

\
