test_that("report_time runs without error", {
    start <- Sys.time()
    expect_no_error(
        suppressMessages(
            downloadR:::report_time(start = start, v = TRUE)
        )
    )
})

test_that("report_time produces a message when v=TRUE", {
    start <- Sys.time()
    expect_message(
        downloadR:::report_time(start = start, v = TRUE),
        "Time difference"
    )
})

test_that("report_time suppresses message when v=FALSE", {
    start <- Sys.time()
    expect_no_message(
        downloadR:::report_time(start = start, v = FALSE)
    )
})
