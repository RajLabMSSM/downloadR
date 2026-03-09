test_that("figshare_download works", {

    testthat::skip_on_cran()
    testthat::skip_if_not(
        echoconda::env_exists(conda_env = "echoR_mini"),
        message = "echoR_mini conda env not available"
    )

    files <- figshare_download(id="14703003", suffix="Earthworm_sFig1_cluster_marker.xlsx")
    testthat::expect_true(all(file.exists(files)))
})
