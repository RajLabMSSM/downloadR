test_that("axel builds correct command and returns output_path", {
    testthat::skip_if_not(
        downloadR:::is_installed("axel"),
        message = "axel not installed"
    )
    testthat::skip_if_offline()
    testthat::skip_on_cran()

    tmp_dir <- tempfile("axel_test_")
    dir.create(tmp_dir)
    on.exit(unlink(tmp_dir, recursive = TRUE), add = TRUE)

    url <- paste0(
        "https://raw.githubusercontent.com/RajLabMSSM/downloadR/",
        "master/DESCRIPTION"
    )
    out <- file.path(tmp_dir, "DESCRIPTION")

    res <- suppressMessages(
        downloadR:::axel(
            input_url = url,
            output_path = out,
            nThread = 1,
            quiet = TRUE,
            verbose = FALSE
        )
    )
    expect_equal(res, out)
    expect_true(file.exists(out))
})

test_that("axel creates output directory if missing", {
    testthat::skip_if_not(
        downloadR:::is_installed("axel"),
        message = "axel not installed"
    )
    testthat::skip_if_offline()
    testthat::skip_on_cran()

    tmp_dir <- file.path(tempdir(), "axel_nested", "sub")
    on.exit(unlink(file.path(tempdir(), "axel_nested"), recursive = TRUE),
            add = TRUE)

    url <- paste0(
        "https://raw.githubusercontent.com/RajLabMSSM/downloadR/",
        "master/DESCRIPTION"
    )
    out <- file.path(tmp_dir, "DESCRIPTION")

    res <- suppressMessages(
        downloadR:::axel(
            input_url = url,
            output_path = out,
            quiet = TRUE,
            verbose = FALSE
        )
    )
    expect_true(dir.exists(tmp_dir))
    expect_equal(res, out)
})

test_that("axel force_overwrite removes existing file", {
    testthat::skip_if_not(
        downloadR:::is_installed("axel"),
        message = "axel not installed"
    )
    testthat::skip_if_offline()
    testthat::skip_on_cran()

    tmp_dir <- tempfile("axel_ow_")
    dir.create(tmp_dir)
    on.exit(unlink(tmp_dir, recursive = TRUE), add = TRUE)

    url <- paste0(
        "https://raw.githubusercontent.com/RajLabMSSM/downloadR/",
        "master/DESCRIPTION"
    )
    out <- file.path(tmp_dir, "DESCRIPTION")
    writeLines("old content", out)

    res <- suppressMessages(
        downloadR:::axel(
            input_url = url,
            output_path = out,
            force_overwrite = TRUE,
            quiet = TRUE,
            verbose = FALSE
        )
    )
    expect_equal(res, out)
})
