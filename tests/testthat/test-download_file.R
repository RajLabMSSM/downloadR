test_that("download_file downloads a small file", {
    testthat::skip_if_offline()
    testthat::skip_on_cran()

    tmp_dir <- tempfile("dl_test_")
    dir.create(tmp_dir)
    on.exit(unlink(tmp_dir, recursive = TRUE), add = TRUE)

    ## Small known file from GitHub
    url <- paste0(
        "https://raw.githubusercontent.com/RajLabMSSM/downloadR/",
        "master/DESCRIPTION"
    )
    out <- file.path(tmp_dir, "DESCRIPTION")

    res <- suppressMessages(
        downloadR:::download_file(
            input_url = url,
            output_path = out,
            verbose = FALSE
        )
    )
    expect_true(file.exists(res))
    expect_gt(file.size(res), 0)
})

test_that("download_file creates output directory if missing", {
    testthat::skip_if_offline()
    testthat::skip_on_cran()

    tmp_dir <- file.path(tempdir(), "dl_nested", "sub1", "sub2")
    on.exit(unlink(file.path(tempdir(), "dl_nested"), recursive = TRUE),
            add = TRUE)

    url <- paste0(
        "https://raw.githubusercontent.com/RajLabMSSM/downloadR/",
        "master/DESCRIPTION"
    )
    out <- file.path(tmp_dir, "DESCRIPTION")

    res <- suppressMessages(
        downloadR:::download_file(
            input_url = url,
            output_path = out,
            verbose = FALSE
        )
    )
    expect_true(file.exists(res))
})

test_that("download_file method='download.file' is treated as 'auto'", {
    testthat::skip_if_offline()
    testthat::skip_on_cran()

    tmp <- tempfile(fileext = ".txt")
    on.exit(unlink(tmp), add = TRUE)

    url <- paste0(
        "https://raw.githubusercontent.com/RajLabMSSM/downloadR/",
        "master/DESCRIPTION"
    )

    ## Should not error -- method is remapped internally to "auto"
    res <- suppressMessages(
        downloadR:::download_file(
            input_url = url,
            output_path = tmp,
            method = "download.file",
            verbose = FALSE
        )
    )
    expect_true(file.exists(res))
})
