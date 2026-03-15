## Additional zenodo_upload tests.

test_that("zenodo_upload requires zen4R namespace", {
    testthat::skip_if_not_installed("zen4R")
    files <- sapply(seq_len(2), function(i) {
        tmp <- tempfile(fileext = ".txt")
        writeLines(letters, tmp)
        return(tmp)
    })
    on.exit(unlink(files), add = TRUE)

    ## Without a valid token, should error during ZenodoManager creation
    expect_error(
        suppressMessages(
            downloadR::zenodo_upload(
                files = files,
                title = "test_upload",
                token = "invalid_token",
                verbose = FALSE
            )
        )
    )
})

test_that("zenodo_upload creates zip when zipfile is specified", {
    testthat::skip_if_not_installed("zen4R")
    files <- sapply(seq_len(2), function(i) {
        tmp <- tempfile(fileext = ".txt")
        writeLines(letters, tmp)
        return(tmp)
    })
    on.exit(unlink(files), add = TRUE)

    ## The function should attempt zipping before the API call fails
    expect_error(
        suppressMessages(
            downloadR::zenodo_upload(
                files = files,
                title = "zip_test",
                zipfile = file.path(tempdir(), "zip_test"),
                token = "invalid_token",
                sandbox = TRUE,
                verbose = FALSE
            )
        )
    )
})
