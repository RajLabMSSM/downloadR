test_that("validate_file returns NULL for valid file", {
    tmp <- tempfile(fileext = ".txt")
    on.exit(unlink(tmp), add = TRUE)
    writeLines("hello world", tmp)

    res <- downloadR:::validate_file(
        output_path = tmp,
        download_method = "test_method",
        verbose = FALSE
    )
    expect_null(res)
})

test_that("validate_file returns retry_method when file does not exist", {
    nonexistent <- tempfile(fileext = ".txt")
    res <- downloadR:::validate_file(
        output_path = nonexistent,
        download_method = "test_method",
        retry_method = "download.file",
        error = FALSE,
        verbose = FALSE
    )
    expect_equal(res, "download.file")
})

test_that("validate_file errors when file missing and error=TRUE", {
    nonexistent <- tempfile(fileext = ".txt")
    expect_error(
        downloadR:::validate_file(
            output_path = nonexistent,
            download_method = "test_method",
            retry_method = NULL,
            error = TRUE,
            verbose = FALSE
        ),
        "download failed"
    )
})

test_that("validate_file returns retry_method for undersized file", {
    tmp <- tempfile(fileext = ".txt")
    on.exit(unlink(tmp), add = TRUE)
    ## Create a zero-byte file (below default min_size=1)
    file.create(tmp)

    res <- downloadR:::validate_file(
        output_path = tmp,
        download_method = "test_method",
        min_size = 1,
        retry_method = "download.file",
        error = FALSE,
        verbose = FALSE
    )
    expect_equal(res, "download.file")
    ## File should have been removed
    expect_false(file.exists(tmp))
})

test_that("validate_file errors for undersized file when error=TRUE", {
    tmp <- tempfile(fileext = ".txt")
    on.exit(unlink(tmp, force = TRUE), add = TRUE)
    file.create(tmp)

    expect_error(
        downloadR:::validate_file(
            output_path = tmp,
            download_method = "test_method",
            min_size = 1,
            retry_method = NULL,
            error = TRUE,
            verbose = FALSE
        ),
        "download failed"
    )
})

test_that("validate_file respects custom min_size", {
    tmp <- tempfile(fileext = ".txt")
    on.exit(unlink(tmp), add = TRUE)
    writeLines("hi", tmp)
    fsize <- file.size(tmp)

    ## With min_size larger than file, should return retry_method
    res <- downloadR:::validate_file(
        output_path = tmp,
        download_method = "test_method",
        min_size = fsize + 100,
        retry_method = "download.file",
        error = FALSE,
        verbose = FALSE
    )
    expect_equal(res, "download.file")
})

test_that("validate_file returns NULL when retry_method is NULL and file missing", {
    nonexistent <- tempfile(fileext = ".txt")
    ## When error=FALSE and retry_method=NULL, function returns invisibly NULL
    res <- downloadR:::validate_file(
        output_path = nonexistent,
        download_method = "test_method",
        retry_method = NULL,
        error = FALSE,
        verbose = FALSE
    )
    expect_null(res)
})
