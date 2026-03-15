## Additional figshare_list tests extending the existing test-figshare_list.R

test_that("figshare_list returns data.table by default", {
    testthat::skip_if_offline()
    testthat::skip_on_cran()

    files <- suppressMessages(
        downloadR::figshare_list(id = "14703003", verbose = FALSE)
    )
    expect_true(data.table::is.data.table(files))
    expect_true(nrow(files) > 0)
    ## Should have expected columns
    expect_true("name" %in% names(files))
    expect_true("download_url" %in% names(files))
})

test_that("figshare_list returns named vector when as_datatable=FALSE", {
    testthat::skip_if_offline()
    testthat::skip_on_cran()

    files <- suppressMessages(
        downloadR::figshare_list(
            id = "14703003",
            as_datatable = FALSE,
            verbose = FALSE
        )
    )
    expect_type(files, "character")
    expect_true(length(files) > 0)
    expect_false(is.null(names(files)))
})

test_that("figshare_list filters by suffix", {
    testthat::skip_if_offline()
    testthat::skip_on_cran()

    files <- suppressMessages(
        downloadR::figshare_list(
            id = "14703003",
            suffix = ".RDS",
            verbose = FALSE
        )
    )
    expect_true(data.table::is.data.table(files))
    ## All returned file names should contain .RDS
    expect_true(all(grepl("\\.RDS", files$name, ignore.case = TRUE)))
})
