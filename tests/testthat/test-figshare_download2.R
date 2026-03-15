## Additional figshare_download tests that don't require conda.

test_that("figshare_download downloads files", {
    testthat::skip_if_offline()
    testthat::skip_on_cran()

    files <- suppressMessages(
        downloadR::figshare_download(
            id = "14703003",
            suffix = "Earthworm_sFig1_cluster_marker.xlsx",
            verbose = FALSE
        )
    )
    expect_true(all(file.exists(files)))
    expect_length(files, 1)
})
