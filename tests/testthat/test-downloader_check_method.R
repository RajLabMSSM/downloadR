test_that("downloader_check_method accepts valid methods", {
    valid_methods <- c("axel", "wget", "download.file",
                       "internal", "wininet", "libcurl", "curl")
    for (m in valid_methods) {
        res <- suppressMessages(
            downloadR:::downloader_check_method(
                download_method = m,
                verbose = FALSE
            )
        )
        expect_equal(res, m)
    }
})

test_that("downloader_check_method converts to lowercase", {
    res <- suppressMessages(
        downloadR:::downloader_check_method(
            download_method = "AXEL",
            verbose = FALSE
        )
    )
    expect_equal(res, "axel")
})

test_that("downloader_check_method defaults invalid method to download.file", {
    res <- suppressMessages(
        downloadR:::downloader_check_method(
            download_method = "invalid_method",
            verbose = FALSE
        )
    )
    expect_equal(res, "download.file")
})

test_that("downloader_check_method takes first element of vector", {
    res <- suppressMessages(
        downloadR:::downloader_check_method(
            download_method = c("wget", "axel"),
            verbose = FALSE
        )
    )
    expect_equal(res, "wget")
})

test_that("downloader_check_method emits message for invalid method", {
    expect_message(
        downloadR:::downloader_check_method(
            download_method = "bogus",
            verbose = TRUE
        ),
        "not recognized"
    )
})
