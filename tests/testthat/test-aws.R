test_that("aws works", {
    bucket <- "s3://broad-alkesgroup-ukbb-ld/"
    input_url <- "UKBB_LD/chr10_135000001_138000001.gz"
    out <- aws(input_url = input_url, bucket = bucket)
    testthat::expect_true(file.exists(out))
})
