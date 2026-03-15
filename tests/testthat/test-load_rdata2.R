## Additional load_rdata tests covering local files and edge cases.

test_that("load_rdata loads a local .rds file", {
    tmp <- tempfile(fileext = ".rds")
    on.exit(unlink(tmp), add = TRUE)

    test_obj <- data.frame(a = 1:5, b = letters[1:5])
    saveRDS(test_obj, tmp)

    res <- downloadR::load_rdata(tmp)
    expect_equal(res, test_obj)
})

test_that("load_rdata loads a local .rda file", {
    tmp <- tempfile(fileext = ".rda")
    on.exit(unlink(tmp), add = TRUE)

    my_data <- list(x = 1:10, y = "hello")
    save(my_data, file = tmp)

    res <- downloadR::load_rdata(tmp)
    expect_equal(res, my_data)
})

test_that("load_rdata loads a local .RData file", {
    tmp <- tempfile(fileext = ".RData")
    on.exit(unlink(tmp), add = TRUE)

    my_data <- data.frame(val = runif(5))
    save(my_data, file = tmp)

    res <- downloadR::load_rdata(tmp)
    expect_equal(res, my_data)
})

test_that("load_rdata errors for unsupported format", {
    expect_error(
        downloadR::load_rdata("somefile.csv"),
        "\\.rda|\\.rdata|\\.rds"
    )
    expect_error(
        downloadR::load_rdata("somefile.txt"),
        "\\.rda|\\.rdata|\\.rds"
    )
})

test_that("load_rdata is case-insensitive for extension matching", {
    tmp <- tempfile(fileext = ".RDS")
    on.exit(unlink(tmp), add = TRUE)

    obj <- list(a = 1)
    saveRDS(obj, tmp)

    res <- downloadR::load_rdata(tmp)
    expect_equal(res, obj)
})

test_that("load_rdata downloads remote .rds via url()", {
    testthat::skip_if_offline()
    testthat::skip_on_cran()

    fileName <- paste0(
        "https://github.com/RajLabMSSM/",
        "Fine_Mapping_Shiny/raw/master/www/BST1.finemap_DT.RDS"
    )
    dat <- suppressMessages(downloadR::load_rdata(fileName))
    expect_true(is.data.frame(dat))
    expect_gte(nrow(dat), 900)
})
