## Additional downloader tests (the existing test-downloader.R requires conda).
## These tests use download.file and do not require echoconda.

test_that("downloader downloads single file with download.file method", {
    testthat::skip_if_offline()
    testthat::skip_on_cran()

    tmp_dir <- tempfile("dl_multi_")
    dir.create(tmp_dir)
    on.exit(unlink(tmp_dir, recursive = TRUE), add = TRUE)

    url <- paste0(
        "https://raw.githubusercontent.com/RajLabMSSM/downloadR/",
        "master/DESCRIPTION"
    )

    res <- suppressMessages(
        downloadR::downloader(
            input_url = url,
            output_dir = tmp_dir,
            download_method = "download.file",
            force_overwrite = TRUE,
            verbose = FALSE
        )
    )
    expect_true(file.exists(res))
    expect_named(res, url)
})

test_that("downloader downloads multiple files", {
    testthat::skip_if_offline()
    testthat::skip_on_cran()

    tmp_dir <- tempfile("dl_multi2_")
    dir.create(tmp_dir)
    on.exit(unlink(tmp_dir, recursive = TRUE), add = TRUE)

    urls <- c(
        paste0("https://raw.githubusercontent.com/RajLabMSSM/downloadR/",
               "master/DESCRIPTION"),
        paste0("https://raw.githubusercontent.com/RajLabMSSM/downloadR/",
               "master/NAMESPACE")
    )

    res <- suppressMessages(
        downloadR::downloader(
            input_url = urls,
            output_dir = tmp_dir,
            download_method = "download.file",
            force_overwrite = TRUE,
            verbose = FALSE
        )
    )
    expect_length(res, 2)
    expect_true(all(file.exists(res)))
    expect_named(res, urls)
})

test_that("downloader errors on mismatched url/path lengths", {
    expect_error(
        suppressMessages(
            downloadR::downloader(
                input_url = c("http://a.com/1", "http://a.com/2"),
                output_path = "/tmp/only_one",
                verbose = FALSE
            )
        ),
        "same length"
    )
})

test_that("downloader skips existing files when force_overwrite=FALSE", {
    testthat::skip_if_offline()
    testthat::skip_on_cran()

    tmp_dir <- tempfile("dl_skip_")
    dir.create(tmp_dir)
    on.exit(unlink(tmp_dir, recursive = TRUE), add = TRUE)

    url <- paste0(
        "https://raw.githubusercontent.com/RajLabMSSM/downloadR/",
        "master/DESCRIPTION"
    )
    out <- file.path(tmp_dir, "DESCRIPTION")
    ## Pre-create the file
    writeLines("preexisting content", out)

    res <- suppressMessages(
        downloadR::downloader(
            input_url = url,
            output_path = out,
            download_method = "download.file",
            force_overwrite = FALSE,
            verbose = FALSE
        )
    )
    ## File should still have old content (not re-downloaded)
    content <- readLines(res)
    expect_true(any(grepl("preexisting", content)))
})
