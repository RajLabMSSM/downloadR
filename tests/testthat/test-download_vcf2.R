## Additional download_vcf tests that don't depend on large remote VCFs.

test_that("download_vcf returns pre-existing file without downloading", {
    tmp_dir <- tempfile("vcf_test_")
    dir.create(tmp_dir)
    on.exit(unlink(tmp_dir, recursive = TRUE), add = TRUE)

    ## Create a fake pre-existing VCF file
    fake_vcf <- file.path(tmp_dir, "test.vcf.gz")
    writeLines("##VCF header", fake_vcf)

    res <- suppressMessages(
        downloadR::download_vcf(
            vcf_url = paste0("http://example.com/", basename(fake_vcf)),
            vcf_dir = tmp_dir,
            force_new = FALSE
        )
    )
    ## save_path should be the existing file path
    expect_equal(res$save_path, fake_vcf)
    ## index_path should be NULL since we skipped download
    expect_null(res$index_path)
})

test_that("download_vcf returns a list with save_path and index_path", {
    tmp_dir <- tempfile("vcf_test2_")
    dir.create(tmp_dir)
    on.exit(unlink(tmp_dir, recursive = TRUE), add = TRUE)

    fake_vcf <- file.path(tmp_dir, "test.vcf.gz")
    writeLines("##VCF", fake_vcf)

    res <- suppressMessages(
        downloadR::download_vcf(
            vcf_url = "http://example.com/test.vcf.gz",
            vcf_dir = tmp_dir,
            force_new = FALSE
        )
    )
    expect_type(res, "list")
    expect_named(res, c("save_path", "index_path"))
})
