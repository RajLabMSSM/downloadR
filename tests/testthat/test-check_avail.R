test_that("check_avail returns tool name when installed", {
    ## bash should always be on PATH on unix-like systems
    res <- suppressMessages(
        downloadR:::check_avail(tool = "bash", verbose = FALSE)
    )
    expect_equal(res, "bash")
})

test_that("check_avail returns tool early when is_installed is TRUE", {
    ## ls should be on PATH; check_avail should return "ls" immediately
    ## without going through the conda path
    res <- suppressMessages(
        downloadR:::check_avail(tool = "ls", verbose = FALSE)
    )
    expect_equal(res, "ls")
})
