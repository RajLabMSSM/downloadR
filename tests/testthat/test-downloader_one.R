test_that("downloader_one returns existing file without re-downloading", {
    ## Create a pre-existing file
    tmp <- tempfile(fileext = ".csv")
    on.exit(unlink(tmp), add = TRUE)
    writeLines("col1,col2\n1,2", tmp)

    res <- suppressMessages(
        downloadR:::downloader_one(
            input_url = "http://example.com/fake.csv",
            output_path = tmp,
            force_overwrite = FALSE,
            verbose = FALSE
        )
    )
    expect_equal(res, tmp)
    ## File content unchanged
    expect_true(any(grepl("col1", readLines(tmp))))
})

test_that("downloader_one emits 'Preexisting file' message", {
    tmp <- tempfile(fileext = ".csv")
    on.exit(unlink(tmp), add = TRUE)
    writeLines("data", tmp)

    expect_message(
        downloadR:::downloader_one(
            input_url = "http://example.com/fake.csv",
            output_path = tmp,
            force_overwrite = FALSE,
            verbose = TRUE
        ),
        "Preexisting file"
    )
})

test_that("downloader_one actually downloads with download.file method", {
    testthat::skip_if_offline()
    testthat::skip_on_cran()

    tmp_dir <- tempfile("dlone_test_")
    dir.create(tmp_dir)
    on.exit(unlink(tmp_dir, recursive = TRUE), add = TRUE)

    url <- paste0(
        "https://raw.githubusercontent.com/RajLabMSSM/downloadR/",
        "master/DESCRIPTION"
    )
    out <- file.path(tmp_dir, "DESCRIPTION")

    res <- suppressMessages(
        downloadR:::downloader_one(
            input_url = url,
            output_path = out,
            download_method = "download.file",
            force_overwrite = TRUE,
            verbose = FALSE
        )
    )
    expect_true(file.exists(res))
    expect_gt(file.size(res), 0)
})
