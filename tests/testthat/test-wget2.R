test_that("wget builds correct command and returns output_path", {
    testthat::skip_if_not(
        downloadR:::is_installed("wget"),
        message = "wget not installed"
    )
    testthat::skip_if_offline()
    testthat::skip_on_cran()

    tmp_dir <- tempfile("wget_test_")
    dir.create(tmp_dir)
    on.exit(unlink(tmp_dir, recursive = TRUE), add = TRUE)

    url <- paste0(
        "https://raw.githubusercontent.com/RajLabMSSM/downloadR/",
        "master/DESCRIPTION"
    )
    out <- file.path(tmp_dir, "DESCRIPTION")

    res <- suppressMessages(
        downloadR:::wget(
            input_url = url,
            output_path = out,
            background = FALSE,
            quiet = TRUE,
            show_progress = FALSE,
            verbose = FALSE
        )
    )
    expect_equal(res, out)
    expect_true(file.exists(out))
    expect_gt(file.size(out), 0)
})

test_that("wget creates output directory if missing", {
    testthat::skip_if_not(
        downloadR:::is_installed("wget"),
        message = "wget not installed"
    )
    testthat::skip_if_offline()
    testthat::skip_on_cran()

    tmp_dir <- file.path(tempdir(), "wget_nested", "sub")
    on.exit(unlink(file.path(tempdir(), "wget_nested"), recursive = TRUE),
            add = TRUE)

    url <- paste0(
        "https://raw.githubusercontent.com/RajLabMSSM/downloadR/",
        "master/DESCRIPTION"
    )
    out <- file.path(tmp_dir, "DESCRIPTION")

    res <- suppressMessages(
        downloadR:::wget(
            input_url = url,
            output_path = out,
            background = FALSE,
            quiet = TRUE,
            show_progress = FALSE,
            verbose = FALSE
        )
    )
    expect_true(dir.exists(tmp_dir))
    expect_equal(res, out)
})

test_that("wget force_overwrite flag works", {
    testthat::skip_if_not(
        downloadR:::is_installed("wget"),
        message = "wget not installed"
    )
    testthat::skip_if_offline()
    testthat::skip_on_cran()

    tmp_dir <- tempfile("wget_ow_")
    dir.create(tmp_dir)
    on.exit(unlink(tmp_dir, recursive = TRUE), add = TRUE)

    url <- paste0(
        "https://raw.githubusercontent.com/RajLabMSSM/downloadR/",
        "master/DESCRIPTION"
    )
    out <- file.path(tmp_dir, "DESCRIPTION")
    writeLines("old content", out)

    res <- suppressMessages(
        downloadR:::wget(
            input_url = url,
            output_path = out,
            background = FALSE,
            force_overwrite = TRUE,
            quiet = TRUE,
            show_progress = FALSE,
            verbose = FALSE
        )
    )
    expect_equal(res, out)
})
