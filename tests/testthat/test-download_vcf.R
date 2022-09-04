test_that("download_vcf works", {
    
    vcf_url <- "https://gwas.mrcieu.ac.uk/files/ieu-a-298/ieu-a-298.vcf.gz"
    out_paths <- download_vcf(vcf_url = vcf_url)
    testthat::expect_true(file.exists(out_paths$save_path))
    testthat::expect_true(file.exists(out_paths$index_path))
})
