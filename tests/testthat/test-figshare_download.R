test_that("figshare_download works", {
    
    files <- figshare_download(id="14703003", suffix="Earthworm_sFig1_cluster_marker.xlsx")
    testthat::expect_true(all(file.exists(files)))
})
